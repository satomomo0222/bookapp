class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update , :index]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @users = User.all
    @books = Book.get_user_books({user_id: @user.id})
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(current_user), notice: 'プロフィールが更新されました。' }
      else
        format.html { render :edit }
      end
    end
  end

  private
  def set_user
    @user = User.find(current_user.id)
  end
  def user_params
    params.require(:user).permit(:username,:profile,:profile_image,:twitter,:instagram,:facebook,:website)
  end
  def correct_user
    redirect_to(root_url) unless @user == current_user
  end

end