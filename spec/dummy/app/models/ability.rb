class Ability
  include CanCan::Ability

  def initialize(user)
    case user.try(:role).try(:name)
    when 'Administrator'
      can :manage, [
        PatronMerge,
        PatronMergeList,
        SeriesStatementMerge,
        SeriesStatementMergeList
      ]
    when 'Librarian'
      can :manage, [
        PatronMerge,
        PatronMergeList,
        SeriesStatementMerge,
        SeriesStatementMergeList
      ]
    end
  end
end
