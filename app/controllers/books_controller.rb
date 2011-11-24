class BooksController < ApplicationController
before_filter :authenticate_user!, :only => [:show, :new, :create]

  def index
    @books= Book.all
  end

  def show
  # Wymagana autoryzacja jest tylko dla testów Devise
    @book = Book.find(params[:id])
  end

  def new
  # Wymagana autoryzacja
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        flash[:notice] = "Dodano."
	format.html { redirect_to(@book) }
	format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
	format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

end
