jQuery ->
  # window.chatController = new Chat.Controller("<%= SITE_URL %>/websocket", true);

window.Chat = {}

class Chat.Controller

  constructor: (url,useWebSockets) ->
    @dispatcher = new WebSocketRails(url,useWebSockets)
    console.log('connect')
    console.log(@dispatcher)
    @dispatcher.on_open = @subscribeChannel 
    @bindEvents()

  bindEvents: =>
    @dispatcher.bind 'new_message', @newMessage
    $('#send').on 'click', @sendMessage

  newMessage: (message) =>
    console.log('newMessage')

  sendMessage: (event) =>
    console.log('sendMessage')
    event.preventDefault()
    message = "test send websocket"
    @dispatcher.trigger 'new_message', {user_name: @user.user_name, msg_body: message}

  subscribeChannel: (message) =>
    channel = @dispatcher.subscribe($('#__current_game').data('game'))
    channel.bind('new', @channelMessage)
    channel.bind('new_all', @channelMessageall)
    channel.bind('quit_this', @quitGame)
    channel.bind('new_game_added', @channelGameall)
    channel.bind('next_turn', @nextTurn)
    channel.bind('draw_from_socket', @drawfromSocket)
    channel.bind('subscriber_part', @channelDestroy)
    channel.bind('send_game_mess', @sendGameMess)
    channel.bind('game_end', @gameEnd)
    channel.bind('game_end_all', @gameEndAll)
    channel.bind('update_scores', @updateScore)
    channel.bind('one_click', @oneClick)
    channel.bind('game_click_end', @gameClickEnd)

  channelMessage: (message) =>
    console.log('channel event received: ' + message)
    set_player(2, message)
    $("#start_game").show()

  sendGameMess: (message) =>
    $("#chat_content").hide().html(message).fadeIn().delay(1000).fadeOut()

  channelMessageall: (message) =>
    $("#"+message[0]).find(".p2").hide().html(message[1]).show(1000);
    $("#"+message[0]).find(".score1, .score2").hide().html("0").show(1000);

  quitGame: (id) =>
    $("#"+id).hide(1000)

  channelGameall: (message) =>
    add_game(message[0], message[1])

  nextTurn: (array) =>
    next_turn([array[0],array[1],array[2]])

  gameClickEnd: =>
    run_end_game()

  drawfromSocket: (data) =>
    console.log(data)
    run_from_socket(parseInt(data[0]),parseInt(data[1]),parseInt(data[2]),parseInt(data[3]),parseInt(data[4]),parseInt(data[5]))

  channelDestroy: =>
    call_set_game_quit()

  oneClick: =>
    update_info()

  gameEnd: (data) =>
    alert("Well done ^^")

  gameEndAll: (data) =>
    str = "<a href='/show_matrixgames/"+data+"'><img alt='Info' src='/assets/info.png' width='25'></a>"
    $("#"+data).find(".gamedone").hide().html(str).show(1000)

  updateScore: (data) =>
    $("#"+data[0]).find(".score1").hide().html(data[1]).show(1000)
    $("#"+data[0]).find(".score2").hide().html(data[2]).show(1000)
