=begin
I spent a while trying to tinker with my code to even get the index to work;
Things are starting to come together though: I'm seeing how classes are
interacting with one another in practicel applications, such as with routers,
controllers, and methods. The syntax looked familiar from the videos, but
I wasn't able ot get it on my own.
=end
class BooksController < ApplicationController
  def index
    @books = Book.all
    render :index
  end

  def new
    Book.new
  end

  def create
    book = Book.new(book_params)

    if book.save
      redirect_to books_url
    else
      flash.now[:errors] = books.errors.full_messages
      render :new
    end
  end

  def destroy
    book = Book.find_by(params[:id])
    book.destroy
    redirect_to books_url
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
