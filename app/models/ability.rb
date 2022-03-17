# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.type == 'Admin'
      can :manage, Category
      can :manage, Doctor
    end

    if user.type == 'Patient'
      can [:show], Category
      can :manage, Appointment
    end

    if user.type == 'Doctor'
      can :manage, Appointment
    end  
  end
end
