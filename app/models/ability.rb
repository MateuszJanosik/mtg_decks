# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Card, Deck]
    if user
      if user.is_admin?
        can :manage, :all
      end
      if user.is_player?
        can [:read, :create], Comment
        can :create, Deck
        can [:update, :destroy], Deck, user_id: user.id
      end
    end
  end

end
