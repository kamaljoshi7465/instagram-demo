class ApplicationController < ActionController::Base
  before_action :verify_authenticity_token
  before_action :current_user

  private

  def current_user
    token = request.headers[:token] || params[:token]
    if token.present?
      begin
        decoded_token ||= JsonWebToken.decode(token)
        if @current_user ||= User.find(decoded_token[:user_id])
        else
          render json: { message: "Invalid token" }, status: :unprocessable_entity
        end
      rescue JWT::VerificationError, JWT::DecodeError
        render json: { message: "Invalid token" }, status: :unprocessable_entity
      end
    end
  end
end
