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
    if params[:message].present?
      @new_message = ChatMessage.new(user_id: current_user.id, 
        chat_group_id: params[:chat_group_id], message: params[:message])
      if @new_message.valid?
        @new_message.save
        @chat_messages = @chat_group.chat_messages
      end
      render partial: "chat_messages"
    end
    @new_chat_message = ChatMessage.new
    @chat_messages = @chat_group.chat_messages
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
