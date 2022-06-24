# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.has_role? :admin
        admin_ability
      elsif user.has_role? :reader
        reader_abiltiy(user)
      end
    else
      guest_ability
    end
  end

  def admin_ability
    can :manage, :all
  end

  def reader_abiltiy(user)
    guest_ability
    can :manage, Question, id: Question.author(user)
    can :manage, Answer, id: Answer.author(user)
    can :start, Test
    can :upvote, Test
    can :downvote, Test
    can :favorite_tests, User, id: user.id
    can :manage, Test, id: Test.author(user)
    #cannot :read, User
    #cannot :manage, User
  end

  def guest_ability
    can :index, Test
  end
end
