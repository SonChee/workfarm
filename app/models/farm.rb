class Farm < ActiveRecord::Base
  CREATE_COLUMNS_FOR_USERS = [:name, :kind, :description, :user_id, 
    :parent_farm_id, :big_farm_id, position_in_farms_attributes: [:id, :user_id, :farm_id, :position, :big_farm_id, :_destroy]]

  has_many :child_farm, class_name: "Farm", foreign_key: :parent_farm_id, dependent: :destroy
  belongs_to :parent_farm, class_name: "Farm", foreign_key: :parent_farm_id
  has_many :small_farm, class_name: "Farm", foreign_key: :big_farm_id, dependent: :destroy
  belongs_to :big_farm, class_name: "Farm", foreign_key: :big_farm_id
  has_many :tasks, dependent: :destroy
  has_many :users, through: :position_in_farms
  has_one :chat_group
  has_many :position_in_farms, dependent: :destroy
  accepts_nested_attributes_for :position_in_farms, allow_destroy: true, reject_if: ->attrs{attrs["user_id"] == "0"}
  
  has_many :leader_in_farms, -> { where position: [1,2] }, class_name: 'PositionInFarm'
  has_many :leaders, through: :leader_in_farms, class_name: "User", :source => :user

  validates :name,  presence: true
  validates :description,  presence: true
  scope :big_farms, ->{where(kind: 1)}
end
