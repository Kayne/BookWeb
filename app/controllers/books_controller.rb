# encoding: utf-8
class BooksController < ApplicationController
before_filter :authenticate_user!, :only => [:new, :create, :my, :destroy, :edit, :update, :add]
before_filter :only_admin!, :only => [:edit, :update]

  def index
    @query = Book.search(params[:q])
    @paginate = @query.result(:distinct => true).page(params[:page])
  end

  def show
  # Need authorization
    @book = Book.find(params[:id])
    if user_signed_in?
      @assigment = Booksassigment.find_by_book_id_and_user_id(@book.id, current_user.id)
    end
  end

  def holders
    @assigments = Booksassigment.find_all_by_book_id(params[:id])
    render(:layout => false)
  end

  def opinions
    @opinions = Opinion.where(:book_id => params[:id]).includes(:user)
    render(:layout => false)
  end

  def opinion_add
    if not params[:opinion].nil? or not params[:opinion].empty?
      Opinion.add_new_opinion(params[:opinion][:book_id], current_user.id, params[:opinion][:title], params[:opinion][:text], params[:opinion][:rate])
      flash[:notice] = "Dodano opinię."
      redirect_to book_path(params[:opinion][:book_id])
    end
  end

  def my
  # Need authorization
    @books = Booksassigment.find_all_by_user_id(current_user.id, :include => :book)
  end

  def add
  # Need authorization
    if !@book = Book.get_book_with_slug_only(params[:id])
      flash[:alert] = "Nie ma takiej pozycji! Może ją dodasz?"
      redirect_to :action => "new"
    end
    @booka = Booksassigment.find_by_book_id(@book.id)
    if @booka != nil
      flash[:alert] = "Masz już tą książkę dodaną do swoich pozycji!"
    else
      if Booksassigment.new_assigment(current_user.id, @book.id)
        flash[:notice] = "Dodano pozycję do listy swoich pozycji"
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
        text = "Dodano książkę #{@book.title} do bazy danych."
        @booksassigment = Booksassigment.create(:user_id => current_user.id, :book_id => @book.id)
        if @booksassigment.save
          flash[:notice] = text + " Dodano ją również do listy twoich książek."
          redirect_to(@book)
        else
          flash[:notice] = text
          flash[:alert] = "Nie udalo się dodać pozycji do listy posiadanych książek."
          redirect_to(@book)
        end
      else
        flash[:alert] = "Nie udało się dodać książki #{@book.title} do bazy danych."
        render :action => "new"
      end

    else
    
      @booksassigment = Booksassigment.get_user_book(current_user.id, @book.id)
      if @booksassigment != nil
        flash[:notice] = "Masz tą książkę dodaną do swoich pozycji."
        redirect_to(@book)
      else
        @booksassigment = Booksassigment.create(:user_id => current_user.id, :book_id => @book.id)
        @booksassigment.save
        flash[:notice] = "Istnieje już taka książka. Dodano do spisu Twoich książek."
	    redirect_to(@book)
      end
    end
  end

  def destroy
    if params[:complete] && current_user.admin?
      @book = Book.find(params[:id])
        booksassigment = Booksassigment.where(:book_id => @book.id)
        booksassigment.each do |b|
          b.destroy
        end
      if @book.destroy
        flash[:notice] = "Usunięto książkę z bazy danych."
        redirect_to books_path
      else
        flash[:alert] = "Nie udało się usunąć książki z bazy danych."
        redirect_to books_path
      end
    else
      @book = Booksassigment.get_user_book(current_user.id, params[:id])
      if @book.destroy
        flash[:notice] = "Usunięto tą pozycje z Twoich książek."
        redirect_to :back
      else
        flash[:notice] = "Nie udało się usunąć tej pozycji! Zgłoś błąd administracji!"
        redirect_to :back
      end
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
