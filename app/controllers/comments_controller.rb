class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    @log = Log.find(params[:log_id])
    @comment = @log.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to [@log]
    end
  end

  def destroy
    @log = Log.find(params[:log_id])
    @comment = @log.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment was deleted successfully."
      redirect_to [@log]
    else
      flash[:alert] = "Comment couldn't be deleted. Try again."
      redirect_to [@log]
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.log]
    end
  end
end
