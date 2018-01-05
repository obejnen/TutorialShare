App.comments = App.cable.subscriptions.create "CommentsChannel",
  # connected: ->
    # Called when the subscription is ready for use on the server
  connected: ->
    setTimeout =>
      @followCurrentTutorial()
    , 1000

  disconnected: ->
    # Called when the subscription has been terminated by the server

  # received: (data) ->
  #   alert data['comment']

  speak: (comment) ->
    @perform 'speak', comment: comment

  collection: -> $('#comments')


  followCurrentTutorial: ->
    tutorialId = @collection().data('tutorial-id')
    if tutorialId
      @perform 'follow', tutorial_id: tutorialId
    else
      @perform 'unfollow'

  received: (data) ->
    @collection().append(data['comment'])