require 'pricer'

module Private
  class EvaluateTargetController < ApplicationController
    def create
      pricer = Pricer.new(
        params.fetch(:country_code),
        params.fetch(:target_group_id),
        params.fetch(:locations),
      )
      render text: pricer.price
    end
  end
end
