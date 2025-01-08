# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [ Card, Deck ]

    return unless user

    if user.is_admin?
      can :manage, :all
    elsif user.is_player?
      can [ :read, :create ], Comment
      can :create, Deck
      can [ :update, :destroy ], Deck, user_id: user.id
    end
  end
end
