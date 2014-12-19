class TargetGroup < ActiveRecord::Base
  has_many :children, class_name: 'TargetGroup', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'TargetGroup'
  belongs_to :country
  belongs_to :panel_provider
end
