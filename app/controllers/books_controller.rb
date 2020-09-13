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
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
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
    @outputs = Output.search_outputs({keyword: params[:search], sort_order: params[:sort]}).where(book_id: @book.id)
    # @outputs = Output.all.ordered_desc
    # @outputs = Output.where(book_id: @book.id).ordered_desc
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