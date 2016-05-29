class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user
    @new_comment = Comment.new

    @comment.save ? flash[:notice] = "Comment saved successfully." : flash[:alert] = "Comment failed to save. Please try again."
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    @comment.destroy ? flash[:notice] = "Comment was deleted successfully." : flash[:alert] = "Error deleting comment. Please try again."
    respond_to do |format|
      format.html
      format.js
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
      redirect_to([comment.post.topic, comment.post])
    end
  end
end