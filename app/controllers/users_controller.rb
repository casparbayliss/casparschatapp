class UsersController < ApplicationController
    def index
        @users = User.all.where.not(id: current_user.id)
    end

    def show
        @user = User.find(params[:id])
    end

    def follow
        if current_user.follow(@user.id)
          respond_to do |format|
            format.html { redirect_to root_path }
            format.js
          end
        end
      end
    
      def unfollow
        if current_user.unfollow(@user.id)
          respond_to do |format|
            format.html { redirect_to root_path }
            format.js { render action: :follow }
          end
        end
      end
    
      private
    
      def set_user
        @user = User.find(params[:id])
      end
end
