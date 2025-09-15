class PostsController < ApplicationController
  # All users can see posts/comments
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :user_stories]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # Pundit hooks
  after_action :verify_authorized, except: [:index, :show, :user_stories]
  after_action :verify_policy_scoped, only: [:index, :user_stories]

  # GET /posts
  def index
    # Everyone can see posts
    @posts = policy_scope(Post)

    respond_to do |format|
      format.html
      format.json { render json: @posts, include: :comments }
    end
  end

  # GET /stories
  # Displays all posts created by the current user
  def user_stories
    if current_user
      @posts = policy_scope(Post.where(user: current_user))
    else
      @posts = [] # Return an empty array if no user is logged in
    end
    render :index # Reuses the existing index view to display the posts
  end

  # GET /posts/:id
  def show
    # Everyone can see posts
    authorize @post, :show?

    respond_to do |format|
      format.html
      format.json { render json: @post, include: :comments }
    end
  end

  # GET /posts/new
  def new
    @post = current_user.posts.build
    authorize @post
  end

  # POST /posts
  def create
    @post = current_user.posts.build(post_params)
    authorize @post

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity, alert: "Failed to create post."
    end
  end

  # GET /posts/:id/edit
  def edit
    authorize @post
  end

  # PATCH/PUT /posts/:id
  def update
    authorize @post

    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity, alert: "Failed to update post."
    end
  end

  # DELETE /posts/:id
  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
