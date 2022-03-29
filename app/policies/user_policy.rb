class UserPolicy < ApplicationPolicy
   

  def index?
    user != nil && user.admin
  end

  def edit?
    update?
  end

  def update?
    user != nil && user.admin
  end

  def destroy?
    user != nil &&  @user.admin
  end
end
