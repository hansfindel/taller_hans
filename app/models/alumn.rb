class Alumn < ActiveRecord::Base
	
	belongs_to :course
	belongs_to :user
	
end
