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
      format.json { render json: @posts, include: :comments }
    end
  end

  # GET /posts/:id
  def show
    authorize @post

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

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render json: @post, status: :created }
      else
        format.html { render :new }
        format.json { render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # GET /posts/:id/edit
  def edit
    authorize @post
  end

  # PATCH/PUT /posts/:id
  def update
    authorize @post

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render json: @post, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/:id
  def destroy
    authorize @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
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
