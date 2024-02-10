class Api::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    profile = Profile.find_by(username: params[:username])
    if profile && profile.user.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: profile.user.id)
      time = Time.now + 24.hours.to_i
      formatted_time = time.strftime("%Y-%m-%d %H:%M")
      render json: { "message": "Successfully login", token: token, time: formatted_time }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end
