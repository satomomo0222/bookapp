class OutputsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_output, only: [:show, :edit, :update, :destroy]
  before_action :set_book, only: [:new, :create]

  # GET /outputs
  # GET /outputs.json
  def index
    @outputs = Output.all
  end

  # GET /outputs/1
  # GET /outputs/1.json
  def show
    @output_user = User.find(@output.user_id)
  end

  # GET /outputs/new
  def new
    @output = Output.new
  end

  # GET /outputs/1/edit
  def edit
  end

  # POST /outputs
  # POST /outputs.json
  def create
    @output = @book.outputs.build(output_params)
    @output.user_id = current_user.id
    #@output.book_id = @book.idにしたいけど、どこで@bookを判定して値を入れれば良いのか。books/show.htmlからbook_idを判定できればいいが、直接urlを入力されると判定できないのではないか。今週のアウトプットの画面から飛んできた場合も、if文でidを指定しなければいけない。架空のidを指定される可能性はあるのか。
    respond_to do |format|
      if @output.save
        format.html { redirect_to @book, notice: 'アウトプットを投稿しました。' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @output.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outputs/1
  # PATCH/PUT /outputs/1.json
  def update
    respond_to do |format|
      if @output.update(output_params)
        format.html { redirect_to book_output_path(@output.book_id, @output.id), notice: 'アウトプットが更新されました。' }
        format.json { render :show, status: :ok, location: @output }
      else
        format.html { render :edit }
        format.json { render json: @output.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outputs/1
  # DELETE /outputs/1.json
  def destroy
    @output.destroy
    respond_to do |format|
      format.html { redirect_to book_outputs_path(@output), notice: 'アウトプットが削除されました' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_output
      @output = Output.find_by(book_id:params[:book_id],id:params[:id])
      # @output = Output.find(params[:id])
    end
    def set_book
      @book = Book.find(params[:book_id])
    end

    # Only allow a list of trusted parameters through.
    def output_params
      # params.fetch(:output, {})
      params.require(:output).permit(:body)
    end
end
