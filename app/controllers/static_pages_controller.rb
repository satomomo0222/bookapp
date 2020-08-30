class StaticPagesController < ApplicationController
  before_action :set_side, only: [:home]

  def home
    @user = current_user
  end

  def about
  end
end
