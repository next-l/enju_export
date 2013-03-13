module EnjuExport
  class Ability
    include CanCan::Ability

    def initialize(user, ip_address = nil)
      case user.try(:role).try(:name)
      when 'Administrator'
        can [:read, :destroy], ExportFile
      when 'Librarian'
        can [:read, :destroy], ExportFile
      when 'User'
        can :read, ExportFile do |export_file|
          export_file.user == user
        end
      end
    end
  end
end
