$ ->
  if $('#publisher').length
    # Initialize an OpenTok Session object
    session = TB.initSession(gon.opentok.sessionId);

    videoOptions = {width: 200, height: 150}
  
    # Initialize a Publisher, and place it into the element with id="publisher"
    publisher = TB.initPublisher(gon.opentok.apiKey, 'publisher', videoOptions);
  
  
    # Attach event handlers
    session.on
      # This function runs when session.connect() asynchronously completes
      sessionConnected: (event) ->
        # Publish the publisher we initialzed earlier (this will trigger 'streamCreated' on other clients)
        if session.capabilities.publish == 1
          session.publish(publisher)
        else
          return
  
    # Connect to the Session using the 'apiKey' of the application and a 'token' for permission
    session.connect(gon.opentok.apiKey, gon.opentok.token);

    msgHistory = document.querySelector('#history')
    session.on 'signal:msg', (event) ->
      msg = document.createElement('p')
      msg.innerHTML = event.data
      msg.className = if event.from.connectionId == session.connection.connectionId then 'mine' else 'theirs'
      msgHistory.appendChild msg
      msg.scrollIntoView()
      return
    form = document.querySelector('form')
    msgTxt = document.querySelector('#msgTxt')
    # Send a signal once the user enters data in the form
    form.addEventListener 'submit', (event) ->
      event.preventDefault()
      session.signal {
        type: 'msg'
        data: msgTxt.value
      }, (error) ->
        if !error
          msgTxt.value = ''
        return
      return

