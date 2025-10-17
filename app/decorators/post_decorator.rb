class PostDecorator < Draper::Decorator
  delegate_all  

  def title_with_category
    "#{object.title} (#{object.category.name})"
  end

  def formatted_message
    object.message.truncate(100) 
  end

  def formatted_created_at
    object.created_at.strftime("%b %d, %Y")
  end
end
