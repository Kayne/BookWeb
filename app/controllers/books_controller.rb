# encoding: utf-8
class BooksController < ApplicationController
before_filter :authenticate_user!, :only => [:show, :new, :create, :my]

  def index
    @books = Book.all(:order => 'id DESC', :limit => 30);
  end

  def show
  # Need authorization
    @book = Book.find(params[:id])
  end

  def my
  # Need authorization
    @books = Booksassigment.find_all_by_user_id(current_user.id)
  end

  def new
  # Need authorization
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def create
    @book = Book.find_by_title(params[:book][:title])
    if (@book == nil)
    
      @book = Book.new(params[:book])

      respond_to do |format|
        if @book.save
	  @booksassigment = Booksassigment.new(:user_id => current_user.id, :book_id => @book.id)
	  @booksassigment.save
          flash[:notice] = "Dodano."
	  format.html { redirect_to(@book) }
	  format.xml  { render :xml => @book, :status => :created, :location => @book }
        else
          format.html { render :action => "new" }
	  format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        flash[:notice] = "Już istnieje taka książka."
        format.html { redirect_to(@book) }
        format.xml { render :xml => @book, location => @book }
      end
    end
  end

end
