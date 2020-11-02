class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_chat
  
    def create
      @message = @chat.messages.new(message_params)
      @messages = @chat.messages.order(created_at: :desc)
      other_user = @chat.sender == current_user ? @chat.recipient : @chat.sender
      if @message.save
        # Notification.create(
        #   recipient: User.last,
        #   actor: current_user,
        #   action: 'sent',
        #   notifiable: self
        # )
        redirect_to chat_messages_path(@chat)
      end
    end

    private
  
    def set_chat
      @chat = Chat.find(params[:chat_id])
    end
  
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
  end