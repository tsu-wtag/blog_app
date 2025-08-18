class PostsController < ApplicationController
  # Ensure user is signed in for most actions
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # Pundit hooks
  after_action :verify_authorized, except: [:index]
  after_action :verify_policy_scoped, only: [:index]

  # GET /posts
  def index
    # Use Pundit scope
    @posts = policy_scope(Post)
    respond_to do |format|
      format.html
      format.json { render json: @posts.to_json(include: :comments) }
    end
  end

  # GET /posts/:id
  def show
    authorize @post
    respond_to do |format|
      format.html
      format.json { render json: @post.to_json(include: :comments) }
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
      render :new
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
      render :edit
    end
  end

  # DELETE /posts/:id
  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully deleted."
  end

  private

  # Set post for show, edit, update, destroy
  def set_post
    @post = Post.find(params[:id])
  end

  # Strong parameters
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
