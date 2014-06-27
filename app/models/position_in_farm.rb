class PositionInFarm < ActiveRecord::Base
  belongs_to :user
  belongs_to :farm
  attr_accessor :checked

  validates :user_id,  presence: true
  validates :farm_id,  presence: true, allow_nil: true

  scope :find_by_id, ->id{where(id: id)}
  scope :find_big_farm_managers_by_farm_id, ->big_farm_id{where(farm_id: big_farm_id, position: 1)}
  scope :find_position_manager_in_big_farm_by_user_id, ->user_id{where(user_id: user_id, position: 1)}
  scope :find_all_position_by_user_id, ->user_id{where(user_id: user_id)}
  scope :find_position_by_user_id_and_farm_id, ->user_id, farm_id{where(user_id: user_id, farm_id: farm_id)}
  scope :current_my_farms, ->big_farm_id, user_id{where(big_farm_id: big_farm_id, user_id: user_id, farm_request: 1)}
  scope :current_my_requests, ->user_id{where(user_id: user_id, farm_request: 0)}
end
