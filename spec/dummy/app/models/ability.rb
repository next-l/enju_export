class Ability
  include CanCan::Ability

  def initialize(user)
    case user.try(:role).try(:name)
    when 'Administrator'
      can [:read, :destroy], ExportFile
    when 'Librarian'
      can [:read, :destroy], ExportFile
    when 'User'
      can :read, ExportFile
    end
  end
end
