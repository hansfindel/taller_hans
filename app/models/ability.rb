class Ability
  include CanCan::Ability

  def initialize(user)
  	

	type=Type.find(user.type_id) if (user && user.type_id)
	id=user.id if user
	user ||= User.new
		
	if user.username && user.username.eql?("admin")
		can :manage, :all
		can :create, Profesor
		cannot :destroy, :all
		can :destroy, Comment
	
		
	elsif type && type.type_name == 'Profesor'
		
		can :manage, User, :id => user.id
		can [:read, :index], [User, @users]
		
		can :read, Course do |c| 
			c.profesors.where(:user_id => user.id)
		end
		cannot [:show, :update], Comment do |c|
			c.oculto == true
		end
		
		can [:read, :index], [Comment, @comments] do |c|
			c.oculto == false
		end
		
		can :destroy, Comment do |comment|
			comment.root.id = user.id
		end 
		cannot [:update, :create], [@profesor, @alumn, @course]
		
	elsif type && type.type_name == 'Alumno'
		#can :read, :all
		can :create, User
		
		cannot [:read, :update, :create], [Profesor, Alumn, Course]
		cannot [:index, :show], User
		#can :update,:comment if self!
		can [:read, :update], [User, @user], :id => user.id
		
		can :create, [Comment, @comment] 
		can [:read, :index], [Comment, @comments] do |c|
			c.oculto == false
		end
		cannot [:show, :update], Comment do |c|
			c.oculto == true
		end
	else 
		can :create, User
		cannot [:read, :update, :create], [Profesor, Alumn, Course]
		cannot [:index, :show], User
		cannot [:create, :update], [Comment]
		can [:read, :index], [Comment, @comments] do |c|
			c.oculto == false
		end
	end  	
  	
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
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
