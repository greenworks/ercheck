class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user

    #user
    #manager
    #admin

       if user.role.name == "admin"
         can :manage, :all
       elsif user.role.name == "manager"
         can :manage, Employee , :creator.in?(User.search_reporting_users(user).collect(&:id))
         can :manage, Employement , :creator.in?(User.search_reporting_users(user).collect(&:id))
         can :update, User do |user_rec|
             user_rec.id == user.id
         end
         can :read, User do |user_rec|
           user_rec.id == user.id
         end
         cannot :destroy, User
         cannot :index, Employee
         cannot :manage, Employer
         cannot :manage, EmployeeImport
       elsif user.role.name == "user"
         can :manage, Employee , :creator.in?(User.search_reporting_users(user).collect(&:id))
         can :manage, Employement , :creator.in?(User.search_reporting_users(user).collect(&:id))
         can :update, User do |user_rec|
             user_rec.id == user.id
         end
         can :read, User do |user_rec|
           user_rec.id == user.id
         end
         cannot :index, User
         cannot :destroy, User
         cannot :manage, Employer
         cannot :manage, EmployeeImport
         cannot :index, Employee
       else
         can :create, User
         cannot :manage, Employer
         cannot :manage, EmployeeImport
         cannot :index, Employee
       end

    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
