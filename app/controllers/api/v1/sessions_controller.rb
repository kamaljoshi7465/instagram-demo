class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      time = Time.now + 24.hours.to_i
      render json: { "message": "Successfully login", token: token, time: time }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end
