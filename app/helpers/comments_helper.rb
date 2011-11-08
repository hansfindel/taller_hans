module CommentsHelper
	
 def nested_messages(comments)
  comments.map do |message, sub_messages|
  	if can? :manage, :all
    	render(message) + content_tag(:div, nested_messages(sub_messages), :class => "nested_messages")
    elsif message.oculto 
    	render(message) + content_tag(:div, nested_messages(sub_messages), :class => "nested_messages")
    end
  end.join.html_safe
 end
 
 def can_see(comment)
 	if comment.oculto && admin?
 		return true
 	elsif !comment.oculto
 		return true
 	else
 		return false
 	end
 end

 
end
