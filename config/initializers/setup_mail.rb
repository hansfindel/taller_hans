ActionMailer::Base.smtp_settings = {  
 :address              => "smtp.gmail.com",  
 :port                 => 587,  
 :domain               => "brainshots.cl",  
 :user_name            => "hans@brainshots.cl",  
 :password             => "hans1111",  
 :authentication       => "plain",  
 :enable_starttls_auto => true  
}
