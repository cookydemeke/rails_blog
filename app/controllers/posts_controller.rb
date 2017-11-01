class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def my_posts
    puts "\n****** my_posts *******"
    # puts "params: #{params.inspect}"
    # @user = User.find(params[:id])
    @my_posts = @current_user.posts
  end

  def new_post
    puts "\n****** Posts: new_post *******"
    redirect_to :home
  end

  # GET /posts
  # GET /posts.json
  def index
    puts "==== Posts: index ===="
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    puts "==== Posts: show ===="
    @comments = @post.comments
    # @comments = Comment.where(:post_id => @post[:id])
    puts "@comments: #{@comments.inspect} "
  end

  # GET /posts/new
  def new
    puts "==== Posts: New ===="
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    puts "==== Posts: edit ===="

  end

  # POST /posts
  # POST /posts.json
  def create
    puts "==== Posts: create ===="
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to all_posts_path(@current_user), notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    puts "==== Posts: update ===="
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    puts "==== Posts: destroy ===="
    @post.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to user_posts_path(@current_user)}
      # format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
end
