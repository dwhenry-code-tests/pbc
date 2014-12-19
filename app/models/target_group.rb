class TargetGroup < ActiveRecord::Base
  belongs_to :parent, class_name: 'TargetGroup'
  belongs_to :country
  belongs_to :panel_provider
end
