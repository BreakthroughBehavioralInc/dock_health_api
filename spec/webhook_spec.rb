require 'dock_health_api'
require 'spec_helper'

RSpec.describe DockHealthApi::Webhook do

  params = { "url": "https://www.funbar.com",
             "secret": "b" * 36,
             "events": ["CREATE_TASK"]
            }
  id = ""

  describe "#create" do
    context "Add new webhook" do
      it "should add new webhook" do
        initial_count = DockHealthApi::Webhook.list.count
        response = DockHealthApi::Webhook.create(params)
        final_count = DockHealthApi::Webhook.list.count
        expect(response["url"]).to eq(params[:url])
        expect(final_count - initial_count).to eq(1)
        id = response["id"]
      end
    end

    context "Add webhook with same url" do
      it "should return 400" do
        initial_count = DockHealthApi::Webhook.list.count
        response = DockHealthApi::Webhook.create(params)
        final_count = DockHealthApi::Webhook.list.count
        expect(response["status"]).to eq(400)
        expect(final_count - initial_count).to eq(0)
      end
    end

    context "Add webhook with bad params" do
      it "should return 400" do
        bad_params = { "url": "https://www.nofunbar.com",
                       "secret": "b" * 36,
                       "id": id
                     }
        initial_count = DockHealthApi::Webhook.list.count
        response = DockHealthApi::Webhook.create(bad_params)
        final_count = DockHealthApi::Webhook.list.count
        expect(response["status"]).to eq(400)
        expect(final_count - initial_count).to eq(0)
      end
    end
  end

  describe "#list" do
    context "list all webhook" do
      it "should list all webhook" do
        response = DockHealthApi::Webhook.list
        expect(response.first.is_a?(DockHealthApi::Webhook))
      end
    end

    context "list specific webhook" do
      it "should return the correct webhook" do
        response = DockHealthApi::Webhook.list(url: params[:url])
        expect(response.first["url"]).to eq(params[:url])
      end
    end

  end

  describe "#get" do
    context "get a specific webhook" do
      it "should get the correct webhook" do
        response = DockHealthApi::Webhook.get(id)
        expect(response["url"]).to eq(params[:url])
      end
    end

    context "get webhook with invalid id" do
      it "should return 400" do
        invalid_id = "123"
        response = DockHealthApi::Webhook.get(invalid_id)
        expect(response["status"]).to eq(400)
      end
    end

    context "get webhook with wrong id" do
      it "should return 404" do
        wrong_id = "a" * 36
        response = DockHealthApi::Webhook.get(wrong_id)
        expect(response["status"]).to eq(404)
      end
    end
  end

  describe "#update" do
    context "update an existing webhook" do
      it "should update an exiting webhook" do
        new_params = { "url": "https://www.nofunbar.com",
                       "secret": "b" * 36,
                       "events": ["CREATE_TASK"],
                       "id": id
                     }
        response = DockHealthApi::Webhook.put(new_params)
        expect(response["url"]).to eq(new_params[:url])
      end
    end
  end

  describe "#delete" do
    context "Delete existing webhook" do
      it "should delete existing webhook" do
        initial_count = DockHealthApi::Webhook.list.count
        response = DockHealthApi::Webhook.delete(id: id)
        final_count = DockHealthApi::Webhook.list.count
        expect(response["enabled"]).to be false
        expect(final_count - initial_count).to eq(-1)
      end
    end
  end

end
