class DogPolicy < ApplicationPolicy
  class Scope < Scope #only for index and the collection.
    def resolve
      scope.all # Dog.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    # @user.is_a? Owner
    true
  end

  def update?
    # @user.is_a? Owner
    true
  end

  def destroy?
    # @user.is_a? Owner
    true
  end

end
