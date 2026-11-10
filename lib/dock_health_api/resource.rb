module DockHealthApi
  class Resource < Object
    MAX_PAGE_SIZE = 200
    MAX_PAGES = 100

    def self.class_name
      name.split("::")[-1]
    end

    def self.url_version
      return "v1"
    end

    def self.client
      DockHealthApi::Client.instance
    end

    def self.resource_url
      if self == Resource
        raise NotImplementedError,
              "Resource is an abstract class. You should perform actions " \
              "on its subclasses (e.g. Patient)"
      end

      "#{client.config.resource_url}/api/#{url_version}/#{class_name.downcase}"
    end

    def self.headers
      {"Content-Type": "application/json", "x-api-key": client.config.api, "x-user-id": client.config.user_id, "x-organization-id": client.config.org_id}
    end

    def self.execute_request(method, url, params: {}, headers: {}, body_params: nil)
      response = client.token_connection.send(method, url, params: params, headers: headers, body: body_params.to_json)
      client.config.debug ? response : response.parsed
    end

    # Fetches every page of a paginated list endpoint and returns the combined records.
    # Bare arrays (unpaginated endpoints) and error responses are returned as-is, so a
    # failure on any page never yields a partial collection.
    def self.execute_paged_request(url, params: {}, headers: {})
      return execute_request(:get, url, headers: headers, params: params) if client.config.debug

      records = []
      (1..MAX_PAGES).each do |page_number|
        page_params = params.merge(paged: true, pageNumber: page_number, pageSize: MAX_PAGE_SIZE)
        response = execute_request(:get, url, headers: headers, params: page_params)
        return response unless response.is_a?(Hash) && response["data"].is_a?(Array)

        records.concat(response["data"])
        # hasMore is inferred from a full page when no total is requested, so an empty page also ends the loop
        return records unless response.dig("page", "hasMore") && response["data"].any?
      end
      raise "#{name} list exceeded #{MAX_PAGES} pages"
    end
  end
end
