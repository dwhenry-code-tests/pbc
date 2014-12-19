Rails.application.routes.draw do
  class InternalConstraint
    def self.matches?(request)
      # TODO: have a secure access token..
      # and possible IP address filtering using a config file to specify valid IP ranges
      request.query_parameters['token'] == 'private' ||
        request.path_parameters['token'] == 'private'
    end
  end

  constraints(InternalConstraint) do
    get '/locations/:country_code' => 'private/locations#show'
    get '/tag_groups/:country_code' => 'private/tag_groups#show'
    post '/evaluate_target' => 'private/evaluate_target#create'
  end

  get '/locations/:country_code' => 'public/locations#show'
  get '/tag_groups/:country_code' => 'public/tag_groups#show'
end
