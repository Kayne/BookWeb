class BooksController < ApplicationController
before_filter :authenticate_user!, :only => [:show]

  def index
    @books= Book.all
  end

  def show
  # Wymagana autoryzacja jest tylko dla testów Devise
    @book = Book.find(params[:id])
  end

end
