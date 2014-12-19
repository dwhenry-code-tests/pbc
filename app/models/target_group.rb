class TargetGroup < ActiveRecord::Base
  belongs_to :parent
  belongs_to :country
  belongs_to :panel_provider
end
