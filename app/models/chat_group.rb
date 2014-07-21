class ChatGroup < ActiveRecord::Base
  UPDATE_COLUMNS_FOR_ADMINS = [:name, :description, :note, :farm_id]	
  has_many :chat_messages
  belongs_to :farm

  validates :farm_id, presence: true
  validates :name, presence: true
end
