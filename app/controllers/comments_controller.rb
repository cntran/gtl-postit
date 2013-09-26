class CommentsController < ApplicationController

  before_action :set_post, only: [:create, :vote]
  before_action :require_user, only: [:create, :vote]

  def create

    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.creator = current_user

    # @comment = @post.comments.build(comment_params) # same as lines 7 & 8

    if @comment.save
      flash[:notice] = "Successfully added a comment."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end

  end

  def vote

    @comment = Comment.find(params[:id])
    vote = Vote.find_by(voteable: @comment, user: current_user)

    respond_to do |format|

      format.html do
        if vote
          flash[:error] = "You already voted on this comment."
        else
          Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
          flash[:notice] = "Your vote was counted."
        end
            
        redirect_to post_path(@post)
      end

      format.js do
        @flash_error = ''
        if vote
          @flash_error = "You already voted on this comment."
        else
          Vote.create(voteable: @comment, user: current_user, vote: params[:vote])
        end
      end    

    end
      
  end

  private

  def set_post
    @post = Post.find_by slug: params[:post_id]
  end

  def comment_params
    params.require(:comment).permit!
  end

end