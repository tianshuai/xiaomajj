class CommentSerializer < ActiveModel::Serializer
  attributes  :id, :content, :status, :user_id, :relateable_id, :relateable_type, :created_at, :updated_at, :user
  
  def user
    if object.user.present?
      u = object.user
      { user_id: u.id, login: u.login, phone: u.login, email: u.email, kind: u.kind }
    else
      {}
    end
  end

end
