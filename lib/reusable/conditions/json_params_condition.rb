module Reusable
  # Public: Provides a Sinatra condition that parses request.body
  # in JSON format and merges it with params.
  #
  # Usage
  #
  #   class App < Sinatra::Application
  #     include Reusable::JSONParamsCondition
  # 
  #     get "/foo", :json_data_params => true, :provides => json do
  #       # params[:text] comes from request.body
  #       { :requested_text => params[:text] }.to_json
  #     end
  #   end
  #
  module JSONParamsCondition
    def self.extended(app)
      app.set(:json_data_params) do |*args|
        condition do
          begin
            params.merge!(JSON.parse(request.body.read.to_s))
          rescue JSON::ParserError
          end

          true
        end
      end
    end
  end
end
