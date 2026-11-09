require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::Resource do
  let(:url) { "https://example.test/api/v1/user" }

  def page(records, has_more:)
    {"data" => records, "page" => {"hasMore" => has_more}}
  end

  def expect_page_request(page_number, response)
    expect(DockHealthApi::User).to receive(:execute_request)
      .with(:get, url, headers: {}, params: hash_including(paged: true, pageNumber: page_number, pageSize: DockHealthApi::Resource::MAX_PAGE_SIZE))
      .ordered
      .and_return(response)
  end

  describe ".execute_paged_request" do
    before { allow(DockHealthApi::Client.instance.config).to receive(:debug).and_return(false) }

    it "returns the records from a single page" do
      expect_page_request(1, page([{"id" => "1"}], has_more: false))

      expect(DockHealthApi::User.execute_paged_request(url)).to eq([{"id" => "1"}])
    end

    it "combines records across multiple pages" do
      expect_page_request(1, page([{"id" => "1"}, {"id" => "2"}], has_more: true))
      expect_page_request(2, page([{"id" => "3"}], has_more: false))

      expect(DockHealthApi::User.execute_paged_request(url).map { |record| record["id"] }).to eq(["1", "2", "3"])
    end

    it "returns an empty array for an empty result" do
      expect_page_request(1, page([], has_more: false))

      expect(DockHealthApi::User.execute_paged_request(url)).to eq([])
    end

    it "stops on an empty page when the total is an exact multiple of the page size" do
      expect_page_request(1, page([{"id" => "1"}], has_more: true))
      expect_page_request(2, page([], has_more: true))

      expect(DockHealthApi::User.execute_paged_request(url).map { |record| record["id"] }).to eq(["1"])
    end

    it "returns the error response instead of a partial collection when a later page fails" do
      error = {"error" => "Internal Server Error", "status" => 500}
      expect_page_request(1, page([{"id" => "1"}], has_more: true))
      expect_page_request(2, error)

      expect(DockHealthApi::User.execute_paged_request(url)).to eq(error)
    end

    it "returns a bare array response as-is" do
      expect_page_request(1, [{"id" => "1"}])

      expect(DockHealthApi::User.execute_paged_request(url)).to eq([{"id" => "1"}])
    end

    it "passes caller params through with the paging params" do
      expect(DockHealthApi::User).to receive(:execute_request)
        .with(:get, url, headers: {}, params: hash_including(active: true, pageNumber: 1))
        .and_return(page([], has_more: false))

      DockHealthApi::User.execute_paged_request(url, params: {active: true})
    end

    it "raises when the page limit is exceeded" do
      stub_const("DockHealthApi::Resource::MAX_PAGES", 2)
      allow(DockHealthApi::User).to receive(:execute_request).and_return(page([{"id" => "1"}], has_more: true))

      expect { DockHealthApi::User.execute_paged_request(url) }.to raise_error(/exceeded 2 pages/)
    end
  end

  describe "DockHealthApi::Crud::List#list" do
    before { allow(DockHealthApi::Client.instance.config).to receive(:debug).and_return(false) }

    it "filters records from every page" do
      allow(DockHealthApi::User).to receive(:resource_url).and_return(url)
      allow(DockHealthApi::User).to receive(:headers).and_return({})
      expect_page_request(1, page([{"email" => "a@test.com"}], has_more: true))
      expect_page_request(2, page([{"email" => "b@test.com"}], has_more: false))

      expect(DockHealthApi::User.list(email: "b@test.com")).to eq([{"email" => "b@test.com"}])
    end
  end
end
