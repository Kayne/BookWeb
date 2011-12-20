# encoding: utf-8
class BooksController < ApplicationController
before_filter :authenticate_user!, :only => [:new, :create, :my, :destroy, :edit, :update]

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

    respond_to do |format|
      format.html # new.html.erb
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
        else
          format.html { render :action => "new" }
        end
      end

    else
    
      @booksassigment = Booksassigment.where(:user_id => current_user.id, :book_id => @book.id).first
      if @booksassigment != nil
        respond_to do |format|
          flash[:notice] = "Masz tą książkę dodaną do swoich pozycji."
          format.html { redirect_to(@book) }
        end
      else
        @booksassigment = Booksassigment.new(:user_id => current_user.id, :book_id => @book.id)
	    @booksassigment.save
        respond_to do |format|
	      flash[:notice] = "Istnieje już taka książka. Dodano do spisu Twoich książek."
	      format.html { redirect_to(@book) }
	    end
      end
    end
  end

  def destroy
    @book = Booksassigment.where(:user_id => current_user.id, :book_id => params[:id]).first
    if @book.destroy
      respond_to do |format|
        flash[:notice] = "Usunięto tą pozycje z Twoich książek."
        format.html { redirect_to :back }
      end
    else
      respond_to do |format|
        flash[:notice] = "Nie udało się usunąć tej pozycji! Zgłoś błąd administracji!"
        format.html { redirect_to :back }
      end
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    respond_to do |format|
      if @book.update_attributes(params[:book])
        flash[:notice] = "Pozycja została zaktualizowana."
        format.html  { redirect_to(@book) }
      else
        format.html  { redirect_to :back }
      end
    end
  end
end
