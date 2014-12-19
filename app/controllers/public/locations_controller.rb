module Public
  class LocationsController < ApplicationController
    def show
      render json: Public::Locations.new(params[:country_code])
    end
  end
end
