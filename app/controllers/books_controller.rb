class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def show
    @show_book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book = Book.new
    @user = User.find_by(id: @show_book.user_id)
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:success] = "You have created book successfully!"
      redirect_to book_path(@book.id)
    else
      @user = User.find(current_user.id)
      @books =Book.all
      flash[:danger] = 'ERROR:Failed to create book'
      render :index
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end 
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success] = 'You have updated book successfully!'
      redirect_to book_path(@book.id)
    else
      flash[:danger] = 'ERROR:Failed to update book'
      render :edit
    end
  end
  
  def edit 
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
    
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
