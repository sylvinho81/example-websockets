class Task < ApplicationRecord
  after_initialize :init
  after_save :broadcast_save
  after_destroy :broadcast_delete

  def init
    self.completed ||= false
  end

  def broadcast_save
    ActionCable.server.broadcast 'tasks', status: 'saved',
                                 id: id,
                                 title: title,
                                 description: description,
                                 completed: completed,
                                 html: render_task
  end

  def broadcast_delete
    ActionCable.server.broadcast 'tasks', status: 'deleted', id: id
  end

  private
  def render_task
    ApplicationController.render(partial: 'tasks/task', locals: { task: self })
  end
end