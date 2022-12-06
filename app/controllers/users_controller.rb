class UsersController < ApplicationController
  def alluser
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Your profile has updated successfully'
      redirect_to user_path(current_user.id)
    else
      flash[:danger] = 'ERROR:Failed to update profile'
      @book = Book.new
      @books = @user.books
      render :edit
    end 
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Welcome!! You have signed up successfully'
      redirect_to user_path(current_user.id) 
    else
      flash[:danger] = 'ERROR:Failed to sign up'
      render :new 
    end
 
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
