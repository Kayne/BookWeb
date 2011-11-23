class BooksController < ApplicationController
before_filter :authenticate_user!, :only => [:show]

  def index
  end

  def show
  # To jest dla testów Devise - tutaj będzie wyświetlana konkretna książka (po ID)
  end

end
