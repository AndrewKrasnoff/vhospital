# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.type == 'Admin'
      can :manage, Category
      can [:update], Doctor
    end

    if user.type == 'Patient'
      can [:show], Category
      can %i[new create index show], Appointment
    end

    if user.type == 'Doctor'
      can %i[show index update], Appointment
    end
  end
end
