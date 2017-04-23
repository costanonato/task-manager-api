module Authenticable
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    render json: { errors: 'Unauthorized access!' }, status: 401 unless current_user.present?
  end
end