class ApplicationController < ActionController::Base
  before_action :verify_authenticity_token
  before_action :current_user

  ERROR_CLASSES = [
    JWT::DecodeError,
    JWT::ExpiredSignature,
  ].freeze

  private
  def current_user
    @current_user ||= User.find(@token[:user_id]) if @token.present?
  end

  def verify_authenticity_token
    return if controller_path.start_with?('admin/')  #skip token for admin

    token = request.headers[:token] || params[:token]
    begin
      @token = JsonWebToken.decode(token)
    rescue *ERROR_CLASSES => exception
      handle_exception exception
    end
  end

  def handle_exception(exception)
    case exception
    when JWT::ExpiredSignature
      return render json: { errors: [token: 'Token has Expired'] },
        status: :unauthorized
    when JWT::DecodeError
      return render json: { errors: [token: 'Invalid token'] },
        status: :bad_request
    end
  end
end
