class StaticPagesController < ApplicationController
  before_action :set_side, only: [:home]

  def home
    @user = current_user
    # p adminuser_signed_in?
  end

  def about
  end
end
