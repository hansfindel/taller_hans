class Comment < ActiveRecord::Base
	has_ancestry
	belongs_to :user
	before_save :calcular_nota
	
	has_attached_file :archivo, 
          :url  => "/assets/archivos/:id/:basename.:extension",
          :path => ":rails_root/public/assets/archivos/:id/:basename.:extension"

	
	validates_presence_of :title, :content, :on => :save, :message => "Debe estar presente"
	validates_numericality_of :calification, :message => "Debe tener una nota"
    validates_inclusion_of :calification, :in => 1..7, :message => "Debe estar entre 1 y 7"	
		
  def commented_on()
 	if self.created_at > 1.minute.ago
 		"Hace pocos segundos"
 	elsif self.created_at > 5.minutes.ago
 		"Comentado hace menos de 5 minutos"	
	else
		self.created_at.strftime("%d/%m/%Y") 
	end
  end
  
  	def calcular_nota
 		if calification.present? && self.parent
 			patter = self.parent 
 			patter.mi_nota
 		end	
 	end
 	
 	def mi_nota
 		sum = 0
 		counter = 0			
 		self.children.each do |c|
 			if c.calification
 				sum += c.calification
 				counter += 1
 			end
 		end
 		
 		if counter > 0
 			self.my_grade = sum/counter
 		else
 			self.my_grade = nil
 		end
 		self.save
 		
 	end
 	
	def lleva_calificacion
		if self.calification && self.parent
			true
		else
			false
		end
	end 	
  
  	def destruir
  		if self.is_childless?
  			self.destroy
  		else
  			self.children.each do |com|
  				com.destruir
  			end
  			self.destroy
  		end
  	end
  	
  	
  
end
