class ChatGroupsController < ::AuthenticatableController
  before_action :authenticate_user!
  before_action :build_object, only: [:new, :create]
  before_action :load_object, only: [:show, :edit, :update, :destroy]
  def index
    @position_in_farms = PositionInFarm.current_my_farms(current_user.current_big_farm_id,current_user.id)
    @chat_groups = Array.new
    @position_in_farms.each do |position|
      @chat_groups << position.farm.chat_group
    end
  end

  def show
    flag_reads = FlagRead.chat_messages_un_read(current_user.id, @chat_group.id)
    flag_reads.each do |flag_read|
      flag_read.update_attributes flag: true
    end
    if request.xhr?
      if params[:message].present?
        @new_message = ChatMessage.new(user_id: current_user.id, 
          chat_group_id: params[:chat_group_id], message: params[:message], 
          to_user_ids: params[:to_user_ids])
        if @new_message.valid?
          @chat_group.farm.users.each do |user|
            if user.id == current_user.id
               @new_message.flag_reads.build user_id: user.id, chat_group_id: @chat_group.id, flag: true
            else
              @new_message.flag_reads.build user_id: user.id, chat_group_id: @chat_group.id
            end
          end
          @new_message.save
          @chat_messages = @chat_group.chat_messages.number_limit 30
        end
        render partial: "chat_messages"
      end
      if params[:number_messages].present?
        @chat_messages = @chat_group.chat_messages.number_limit params[:number_messages]
        render partial: "chat_messages"
      end
      if params[:delete_all_messages].present?
        @chat_messages = @chat_group.chat_messages
        @chat_messages.destroy_all
        render partial: "chat_messages"
      end
    end
    @new_chat_message = ChatMessage.new
    @chat_messages = @chat_group.chat_messages.number_limit 30
  end

  def new
    
  end

  def create
    @chat_group.attributes = chat_group_params
    if @chat_group.valid?
      farm = Farm.find_by(id: params[:chat_group][:farm_id])
      if farm.leaders.include? current_user 
        if farm.chat_group.nil?
          @chat_group.save
          redirect_to chat_group_path(@chat_group)
        else
          flash.now[:error] = "Chat group of farm is exist"
          render action: :new
        end
      else
        flash.now[:error] = "you don't have permit"
        redirect_to root_path
      end
    else
      render action: :new
    end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

  def build_object
    @chat_group = ChatGroup.new
  end

  def load_object
    @chat_group = ChatGroup.find params[:id]
  end
  def chat_group_params
    params.require(:chat_group).permit ChatGroup::UPDATE_COLUMNS_FOR_ADMINS
  end
  # def chat_message_params
  #   params.require(:chat_message).permit ChatMessage::UPDATE_COLUMNS_FOR_ADMINS
  # end
end
