class WebSocketController < WebsocketRails::BaseController

  $connection_store = {}

  def client_connected
    logger.info "------------client_connected----------"
    logger.info "#{client_id}"
    system_msg :new_message, "client #{client_id} connected"
  end

  def new_message
    logger.info "------------new_message----------"
    #user_msg :new_message, message[:msg_body].dup
    broadcast_message :new_message, { 
      user_name:  message[:user_name], 
      received:   Time.now.to_s(:short), 
      msg_body:   ERB::Util.html_escape(message[:msg_body].dup) 
    }
  end

  def new_user
    logger.info "------------------new_user--------------"
    #logger.info "user_id: " + message[:user_id].to_s + "----"
    #connection_store[:user] = { user_name: message[:user_name] }
    #user_msg :new_message, "add new user"
    #broadcast_user_list
  end

  def change_username
    connection_store[:user] = sanitize(message)
    broadcast_user_list
  end

  def delete_user
    connection_store[:user] = nil
    system_msg "client #{client_id} disconnected"
    broadcast_user_list
  end

  def broadcast_user_list
    users = connection_store.collect_all(:user)
    broadcast_message :user_list, users
  end

  def reverse_auction_players
    
  end
end