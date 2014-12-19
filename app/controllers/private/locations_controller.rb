module Private
  class LocationsController < ApplicationController
    def show
      render json: Private::Locations.new(params[:country_code])
    end
  end
end
