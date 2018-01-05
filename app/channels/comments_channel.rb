class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'comments_channel', comment: data['comment']
  end

  def follow(params)
    stop_all_streams
    stream_from "tutorial:#{params['tutorial_id'].to_i}:comments"
  end

  def unfollow
    # stop_all_streams
  end
end
