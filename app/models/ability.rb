# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.type == 'Admin'
      can :manage, Category
      can %i[index show update], Doctor
      can :read, Patient
    end

    if user.type == 'Patient'
      can [:show], Category
      can %i[index show new create], Appointment
    end

    if user.type == 'Doctor'
      can %i[index show update], Appointment
    end
  end
end
