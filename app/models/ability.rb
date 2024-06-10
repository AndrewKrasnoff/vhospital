class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    admin_access if user.type == 'Admin'
    patient_access if user.type == 'Patient'
    doctor_access if user.type == 'Doctor'
  end

  private

  def admin_access
    can :manage, Category
    can %i[index show update], Doctor
    can :read, Patient
  end

  def patient_access
    can [:show], Category
    can %i[index show new create], Appointment
  end

  def doctor_access
    can %i[index show update], Appointment
  end
end
