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
    @outputs = Output.where(book_id: @book.id).ordered_desc
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