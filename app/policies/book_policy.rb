class BookPolicy < ApplicationPolicy
  attr_reader :user, :book

  def initialize(user, book)
    @user = user
    @book = book
  end

  def index?
    true
  end

  def show?
    user!=nil
  end

  def edit?
    update?
  end
  
  def update?
    user!=nil && @user.admin
  end

  def new?
    create?
  end
  
  def create?
    user!=nil &&  @user.admin
  end

  def destroy?
    user!=nil && @user.admin
  end

   


end
