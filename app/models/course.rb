class Course < ActiveRecord::Base
	has_many :alumns
	has_many :users, :through => :alumns
	has_many :profesors
	has_many :users, :through => :profesors
	
	
end
