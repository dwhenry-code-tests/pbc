module Private
  class TagGroupsController < ApplicationController
    def show
      render json: Private::TagGroups.new(params[:country_code])
    end
  end
end
