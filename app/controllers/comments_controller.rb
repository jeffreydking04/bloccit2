class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    comment.user = current_user

    comment.save ? flash[:notice] = "Comment saved successfully." : flash[:alert] = "Comment failed to save. Please try again."
    redirect_to([@post.topic, @post])
  end

  def destroy
    @post = Post.find(params[:post_id])
    comment = @post.comments.find(params[:id])

    comment.destroy ? flash[:notice] = "Comment was deleted successfully." : flash[:alert] = "Error deleting comment. Please try again."
    redirect_to([@post.topic, @post])
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