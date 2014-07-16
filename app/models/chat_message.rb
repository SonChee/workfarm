class ChatMessage < ActiveRecord::Base
  UPDATE_COLUMNS_FOR_ADMINS = [:id, :user_id, :chat_group_id, :message]
  belongs_to :chat_group
  belongs_to :user
end
