class TasksChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'tasks'
  end
end