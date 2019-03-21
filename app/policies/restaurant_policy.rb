class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all

      # dans le cas d'un SAAS par exemple
      # La liste des restaurants ne contient que
      # les restaurants de l'utilisateur
      # Restaurant.where(....)
      # scope.where(user: user)
    end
  end

  def create?
    true # anyone can create a restaurant
  end

  def show?
    true # anyone can view a restaurant
  end

  def update?
    # only onwer can edit a restaurant
    # user <=> current_user
    # record <=> l'argument passé à `authorize` dans le controller
    # record <=> @restaurant

    restaurant_owner_or_admin?
  end

  def destroy?
    restaurant_owner_or_admin?
  end

  private

  def restaurant_owner_or_admin?
    record.user == user || user.admin
  end
end
