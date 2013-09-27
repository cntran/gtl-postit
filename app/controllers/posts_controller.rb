class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:new, :create, :edit, :update, :vote]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse


    # expose api endpoints
    respond_to do |format|

      format.html { render :index }
      format.js { render json: @posts }
      format.xml { render xml: @posts }

    end

  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Successfully created a new post."
      redirect_to root_path
    else
      render :new
    end

  end

  def update

    if @post.update(post_params)
      flash[:notice] = "Successfully updated post."
      redirect_to post_path(params[:id])
    else
      render :edit
    end

  end

  def vote

    vote = Vote.find_by(voteable: @post, user: current_user)

    respond_to do |format|

      format.html do
        if vote 
          flash[:error] = "You already voted on this post."
        else
          Vote.create(voteable: @post, user: current_user, vote: params[:vote])
          flash[:notice] = "Your vote was counted."
        end
        redirect_to root_path
      end

      format.js do
        @flash_error = ''
        if vote 
          @flash_error = "You already voted on this post."
        else
          Vote.create(voteable: @post, user: current_user, vote: params[:vote])
        end
      end

    end

  end

  private

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def post_params
    params.require(:post).permit!
  end

end
