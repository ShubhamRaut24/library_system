class BookPolicy < ApplicationPolicy
  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  def index?
    true
  end

  def edit?
    update?
  end
  
  def update?
    @user.admin
  end

  def new?
    create?
  end
  
  def create?
    @user.admin
  end

  def destroy?
    @user.admin
  end

  def add_book?
   
  end


end
