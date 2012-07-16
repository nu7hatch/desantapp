module Reusable
  module JSONParamsCondition
    def self.extended(app)
      app.set(:json_data_params) do |*args|
        condition do
          begin
            params.merge!(JSON.parse(request.body.read.to_s))
          rescue JSON::ParserError
            # ...
          end

          true
        end
      end
    end
  end
end
