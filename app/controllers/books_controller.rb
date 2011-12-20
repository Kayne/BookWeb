# encoding: utf-8
class BooksController < ApplicationController
before_filter :authenticate_user!, :only => [:new, :create, :my, :destroy, :edit, :update, :add]

  def index
    @query = Book.search(params[:q])
    @paginate = @query.result(:distinct => true)
    #@books = Book.all(:order => 'id DESC', :limit => 30);
    @paginate = @paginate.paginate(:page => params[:page], :per_page => 3)
  end

  def show
  # Need authorization
    @book = Book.find(params[:id])
    @assigments = Booksassigment.find_all_by_book_id(@book.id)
  end

  def my
  # Need authorization
    @books = Booksassigment.find_all_by_user_id(current_user.id, :include => :book)
  end

  def add
  # Need authorization
    if !@book = Book.find(params[:id], :select => "id, slug")
      flash[:alert] = "Nie ma takiej pozycji! Może ją dodasZ?"
      redirect_to :action => "new"
    end
    @booka = Booksassigment.find_by_book_id(@book.id)
    if @booka != nil
      flash[:alert] = "Masz już tą książkę dodaną do swoich pozycji!"
    else
      @assigment = Booksassigment.new
      @assigment.user_id = current_user.id
      @assigment.book_id = @book.id
      if @assigment.save
        flash[:notice] = "Dodano"
      else
        flash[:alert] = "Nie udało się dodać pozycji"
      end
    end
    redirect_to (@book)
  end

  def new
  # Need authorization
    @book = Book.new
  end

  def create
  # Need authorization
    @book = Book.find_by_title(params[:book][:title])
    if (@book == nil)
    
      @book = Book.new(params[:book])

      if @book.save
	    @booksassigment = Booksassigment.new(:user_id => current_user.id, :book_id => @book.id)
	    @booksassigment.save
        flash[:notice] = "Dodano."
	    redirect_to(@book)
      else
        render :action => "new"
      end

    else
    
      @booksassigment = Booksassigment.where(:user_id => current_user.id, :book_id => @book.id).first
      if @booksassigment != nil
        flash[:notice] = "Masz tą książkę dodaną do swoich pozycji."
        redirect_to(@book)
      else
        @booksassigment = Booksassigment.new(:user_id => current_user.id, :book_id => @book.id)
	    @booksassigment.save
        flash[:notice] = "Istnieje już taka książka. Dodano do spisu Twoich książek."
	    redirect_to(@book)
      end
    end
  end

  def destroy
  # Need authorization
    @book = Booksassigment.where(:user_id => current_user.id, :book_id => params[:id]).first
    if @book.destroy
      flash[:notice] = "Usunięto tą pozycje z Twoich książek."
      redirect_to :back
    else
      flash[:notice] = "Nie udało się usunąć tej pozycji! Zgłoś błąd administracji!"
      redirect_to :back
    end
  end

  def edit
  # Need authorization
    @book = Book.find(params[:id])
  end

  def update
  # Need authorization
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      flash[:notice] = "Pozycja została zaktualizowana."
      redirect_to(@book)
    else
      format.html redirect_to :back
    end
  end
end
