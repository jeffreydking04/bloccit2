class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    if params[:post_id]
      @post = Post.find(params[:post_id])
      comment = @post.comments.new(comment_params)
      comment.user = current_user
    else
      @topic = Topic.find(params[:topic_id])
      comment = @topic.comments.new(comment_params)
      comment.user = current_user
    end

    comment.save ? flash[:notice] = "Comment saved successfully." : flash[:alert] = "Comment failed to save. Please try again."
    @post ? redirect_to([@post.topic, @post]) : redirect_to(@topic)
  end

  def destroy
    if params[:post_id]
      @post = Post.find(params[:post_id])
      comment = @post.comments.find(params[:id])
    else
      @topic = Topic.find(params[:topic_id])
      comment = @topic.comments.find(params[:id])
    end

    comment.destroy ? flash[:notice] = "Comment was deleted successfully." : flash[:alert] = "Error deleting comment. Please try again."
    @post ? redirect_to([@post.topic, @post]) : redirect_to(@topic)
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