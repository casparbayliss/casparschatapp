class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  after_create :create_notification

  validates_presence_of :body, :chat_id, :user_id

  def message_time
    created_at.strftime("%d %b, %Y")
  end

  def notification_to_s
    "you a message"
  end

  private

  def create_notification
    if chat.recipient == user
      recipient = chat.sender
    else
      recipient = chat.recipient
    end
    Notification.create(
      recipient: recipient,
      actor: user,
      action: 'started',
      notifiable: self
    )
  end
end
