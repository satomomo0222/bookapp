class StaticPagesController < ApplicationController
  before_action :set_side, only: [:home]

  def home
    @user = current_user
    @outputs = Output.where(book_id: @thisweek.id)
  end

  def about
  end
end
