class User < ActiveRecord::Base
	belongs_to :type
	has_many :login_failures
	
	has_many :alumns
	has_many :courses, :through => :alumns
	
	has_many :profesors
	has_many :courses, :through => :profesors
	
	attr_accessible :username, :email, :password, :password_confirmation, :rut, :type_id, :verificador, :active
	attr_accessor :password, :verificador
	before_save :encrypt_password
	
	validates_presence_of :username, :password, :email, :rut, :verificador, :on => :create, :message => "debe estar presente"
	validates_confirmation_of :password, :on => :create, :message => "no se hace match con el password"
	validates_uniqueness_of :username, :email, :rut, :message => "ya existe un registro con este valor"
	validates_format_of :rut,
                      :with => /\A(\d{7,9})\Z/i,
                      :message => "no es valido."
                      
    validates_format_of :email,
    				  :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    				  :message => "no corresponde al formato"

    validates_format_of :username,
    				  :with => /^[:alpha:][.]*/i,
    				  :message => "debe comenzar con una letra!"
    
    validates_format_of :verificador,
    				  :with => /^[-0-9k]/i,
    				  :message => "debe ser un digito o, en su defecto, k",
    				  :on => :create				  				  

    validates_length_of :password,
    				  :within => 4..16 ,
    				  :too_short => "debe tener al menos 4 caracteres", 
    				  :too_long => "debe tener a lo mas 16 caracteres",
    				   :on => :create
    				  
    validate :validar_rut, :message=> "no calza el digito verificador",  :on => :create
	
	def encrypt_password
 		if password.present?
 			self.password_salt = BCrypt::Engine.generate_salt
 			self.password_hash = sup_encrypt(password,password_salt)
 		end	
 	end

 	def sup_encrypt(pass, salt)
 		b=BCrypt::Engine.hash_secret(BCrypt::Engine.hash_secret(pass, salt), salt)
 		BCrypt::Engine.hash_secret(BCrypt::Engine.hash_secret(pass, b), b)
 	end	
	
 	def self.sup_encrypt(pass, salt)
 		b=BCrypt::Engine.hash_secret(BCrypt::Engine.hash_secret(pass, salt), salt)
 		BCrypt::Engine.hash_secret(BCrypt::Engine.hash_secret(pass, b), b)
 	end	
 	
 	def self.authenticate_mail(mail, password)
 		user = User.find_by_email(mail)
 		if user && user.active && user.password_hash == sup_encrypt(password, user.password_salt)
 			user
 		else
 			nil
 		end
 	end	
 	def self.authenticate_rut(rut, password)
 		user = User.find_by_rut(rut)
 		if user && user.active && user.password_hash == sup_encrypt(password, user.password_salt)
 			user
 		else
 			nil
 		end
 	end	
 	def self.authenticate_name(name, password)
 		user = User.find_by_username(name)
 		if user && user.active && user.password_hash == sup_encrypt(password, user.password_salt)
 			user
 		else
 			nil
 		end
 	end	
 	
 	def self.get_id(thing)
 		if thing && thing.include?("@")
 			dd=User.find_by_email(thing)
 		elsif thing && thing.to_i>0
 			dd=User.find_by_rut(thing)
 		elsif thing
 			dd=User.find_by_username(thing)
 		end
 		if dd
 			dd.id
 		else
 			"holo"
 		end	
 	end	
 	
 	def validar_rut
 		errors.add(:verificador, "doesn't match") if verificador != dv(rut) 
 	end
 	
   def dv(rut)
    crut = rut.to_s
    f=2
    i=(crut.size) -1
    ss=0
    while i >= 0
      ss += f * ((crut[i].to_i) -48)
      f += 1
      f = 2 if f > 7
      i -= 1
    end
    ss = 11 - (ss % 11)
    if ss == 10
      "K"
    else
      if ss == 11
        "0"
      else
        ss.to_s
      end
    end
  end
 
  def self.digv(rut)
  	dv(rut)
  end	
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = BCrypt::Engine.generate_salt
    end while User.exists?(column => self[column])
  end
  
  def self.search(search)
  	if search
  		where('username Like ?', "%#{search}%")
  	else
  		scoped
  	end
  end 
  
end
