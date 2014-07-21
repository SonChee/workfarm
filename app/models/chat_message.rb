class ChatMessage < ActiveRecord::Base
  UPDATE_COLUMNS_FOR_ADMINS = [:id, :user_id, :chat_group_id, :message, :to_user_ids,  flag_reads_attributes: [:id, 
  	:user_id, :chat_message_id, :chat_group_id, :flag, :_destroy]]
  belongs_to :chat_group
  belongs_to :user
  has_many :flag_reads, dependent: :destroy
  accepts_nested_attributes_for :flag_reads, allow_destroy: true, reject_if: :all_blank

  scope :number_limit, ->number{order("created_at desc").limit(number)}
end
