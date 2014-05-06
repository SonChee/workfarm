class PositionInFarm < ActiveRecord::Base
  belongs_to :user
  belongs_to :farm
  attr_accessor :checked

  validates :user_id,  presence: true
  validates :farm_id,  presence: true

  scope :find_big_farm_managers_by_farm_id, ->big_farm_id{where(farm_id: big_farm_id, position: 1)}
  scope :find_position_manager_in_big_farm_by_user_id, ->user_id{where(user_id: user_id, position: 1)}
  scope :find_all_position_by_user_id, ->user_id{where(user_id: user_id)}
  scope :find_position_by_user_id_and_farm_id, ->user_id, farm_id{where(user_id: user_id, farm_id: farm_id)}
end
