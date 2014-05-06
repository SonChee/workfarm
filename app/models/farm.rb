class Farm < ActiveRecord::Base
  CREATE_COLUMNS_FOR_USERS = [:name, :kind, :description, :user_id, 
    :parent_farm_id, position_in_farms_attributes: [:id, :user_id, :farm_id, :position, :_destroy]]

  has_many :child_farm, class_name: "Farm", foreign_key: :parent_farm_id, dependent: :destroy
  belongs_to :parent_farm, class_name: "Farm", foreign_key: :parent_farm_id
  has_many :tasks, dependent: :destroy
  has_many :users, through: :position_in_farms
  has_many :position_in_farms, dependent: :destroy
  accepts_nested_attributes_for :position_in_farms, allow_destroy: true, reject_if: ->attrs{attrs["user_id"] == "0"}

  validates :name,  presence: true
  validates :description,  presence: true
  scope :big_farms, ->{where(kind: 1)}
end
