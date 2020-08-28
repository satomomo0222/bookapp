class StaticPagesController < ApplicationController
  def home
    @user = current_user
    @book = Book.find(2)
  end

  def about
  end
end
