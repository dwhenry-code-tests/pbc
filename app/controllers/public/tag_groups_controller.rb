module Public
  class TagGroupsController < ApplicationController
    def show
      render json: Public::TagGroups.new(params[:country_code])
    end
  end
end
