class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update , :mypage]

  def mypage
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_mypage_path, notice: 'プロフィールが更新されました。' }
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
    params.require(:user).permit(:username,:profile,:profile_image_id,:twitter,:instagram,:facebook,:website)
  end

end