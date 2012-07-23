module Desant
  # Public: Contains helpers for various analytics and metrics 
  # systems.
  module MetricHelpers
    # Public: Used in the view includes scripts appropriate for
    # used metrics system.
    def include_metric_scripts
      if ENV['GOOGLE_ANALYTICS_UA']
        erb :'metrics/google_analytics'
      else
        # TODO: kissmetrics, mixpanel...
      end
    end
  end
end
