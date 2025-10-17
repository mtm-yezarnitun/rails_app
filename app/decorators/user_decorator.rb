class UserDecorator < Draper::Decorator
  delegate_all

  def member_since
    object.created_at.strftime("%b %Y")
  end

end
