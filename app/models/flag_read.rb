class FlagRead < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat_message
  belongs_to :chat_group

  scope :chat_messages_un_read, ->user_id, chat_group_id{where(user_id: user_id, chat_group_id: chat_group_id, flag: false)}
end
