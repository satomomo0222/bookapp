class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  # def create
  #   @comment = Comment.new(comment_params)
  #   @comment.user_id = current_user.id
  #   if @comment.save
  #     redirect_back(fallback_location: root_path)
  #   else
  #     redirect_back(fallback_location: root_path)
  #   end
  # end

  def create
    @output = Output.find(params[:output_id])
    #投稿に紐づいたコメントを作成
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment_output = @comment.output
    if @comment.save
      #通知の作成
      @comment_output.create_notification_comment!(current_user, @comment.id)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :output_id)
  end
end
