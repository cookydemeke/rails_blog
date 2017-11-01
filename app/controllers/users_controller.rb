class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # ==== GET/home =======
  def home
    puts "\n****** home *******"
    # @current_user = User.find(3)
  end

    def index
      puts "\n****** index *******"
      # @current_user = User.find(3)
      @users = User.all
    end

  # ==== GET/Index =======
  def login_form
    puts "\n****** login_form *******"
    # @users = User.all
    # @current_user = User.find(3)
  end

  # == login code ==
  def login
      puts "\n******* login *******"
      ok_params = login_params
      puts "ok_params: #{ok_params.inspect}"
      @user = User.where(username: ok_params[:username]).first
      puts "@user: #{@user.inspect}"
      if @user
          if @user.password == ok_params[:password]
              session[:user_id] = @user[:id]
              puts "session[:user_id]: #{session[:user_id].inspect}"
              current_user
              redirect_to :home
          else
              redirect_to "/login", notice: 'Your password was incorrect.  Please try again'
          end
      else
          redirect_to "/login", notice: 'Your username was incorrect.  Please try again'
      end
  end

  def logout
    puts "\n****** logout *******"
    session[:user_id] = nil
    redirect_to :home, notice: 'byebye'
    # @current_user = User.find(3)
  end

  def current_user_menu
    puts "\n****** current_user_menu *******"
    # @current_user = User.find(3)
  end


  def show
    puts "\n****** show *******"
  end

  # GET /users/new
  def new
    puts "\n****** new *******"
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    puts "\n****** edit *******"
  end

  # POST /users
  # POST /users.json
  def create
    puts "\n****** create *******"
    # binding.pry
    ok_params = user_params.except(:email_confirmation)
    @user = User.new(ok_params)
    puts "@user: #{@user}"

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    puts "\n****** update *******"
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    puts "\n****** destroy *******"
    @user.destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private


    # Use callbacks to share common setup or constraints between actions.
    def set_user
      puts "\n****** set_user *******"
      @user = User.find(params[:id])
    end

    # == login_params code ==
    def login_params
        puts "******* login_params *******"
        # WHITE LISTED, ALLOWED.
        params.permit(:username, :password)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      puts "\n****** user_params *******"
      params.require(:user).permit(:firstname, :lastname, :email, :username, :password, :email_confirmation)
    end
end
