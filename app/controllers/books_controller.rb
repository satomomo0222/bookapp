class BooksController < ApplicationController
  before_action :set_book, only: [:show]
  before_action :set_side, only: [:show]
  #ここで管理者権限を与える

  def search
    @books = Book.search_books({keyword: params[:search]})
  end

  # GET /books
  # GET /books.json
  def index
    if params[:search].present?
      @search = params[:search]
    end
    @books = Book.search_books({keyword: params[:search]}).created_desc
  end

  # GET /books/1
  # GET /books/1.json

  def root
    books = Book.created_desc.first(2)
    @thisweek = books[1]
    @book = @thisweek
    redirect_to(book_path(@book))
  end

  def show
    if params[:search].present?
      @search = params[:search]
    end
    if params[:sort].present?
      sort_order = params[:sort]
      if sort_order == "0"
        @sort_order_word = "新しい順"
      elsif sort_order == "1"
        @sort_order_word = "古い順"
      elsif sort_order == "2"
        @sort_order_word = "いいねの多い順"
      end
    else
      @sort_order_word = "新しい順"
    end


    if params[:narrow_down].present?
      @narrow_down = params[:narrow_down]
    else
      @narrow_down = "0"
    end

    if user_signed_in?
      query = {keyword: params[:search], sort_order: params[:sort], narrow_down: params[:narrow_down], current_user_id: current_user.id}
    else
      query = {keyword: params[:search], sort_order: params[:sort], narrow_down: params[:narrow_down]}
    end

    #全ての投稿
    if sort_order == "2"
      @outputs = Output.search_outputs(query).where(book_id: @book.id).sort{|a,b| b.favorites.count <=> a.favorites.count}
    else
      @outputs = Output.search_outputs(query).where(book_id: @book.id)
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      # params.fetch(:book, {})
      params.require(:book).permit(:title,:body,:book_image,:amazon_url,:rakuten_url)
    end

end