module DockHealthApi
  class Resource < Object
    def self.class_name
      name.split("::")[-1]
    end

    def self.url_version
      return "v1"
    end

    def self.client
      @client ||= DockHealthApi::Client.active_client
    end

    def self.resource_url
      if self == Resource
        raise NotImplementedError,
              "Resource is an abstract class. You should perform actions " \
              "on its subclasses (e.g. Patient)"
      end

      "#{client.config.resource_url}/api/#{url_version}/#{class_name.downcase}"
    end

    def self.execute_request(method, url, params: {}, headers: {}, body_params: nil)
      client.token_connection.send(method, url, params: params, headers: headers, body: body_params.to_json)
    end
  end
end
