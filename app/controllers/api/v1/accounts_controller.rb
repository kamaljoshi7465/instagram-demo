class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      create_profile(user)
      token = JsonWebToken.encode(user_id: user.id)
      time = Time.now + 24.hours.to_i
      formatted_time = time.strftime("%Y-%m-%d %H:%M")
      user_details = {token: token, time: formatted_time, user_name: user.profile&.username}
      render json: { message: 'User created successfully', user_details: user_details }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  private
  def user_params
    params.require(:accounts).permit(:email, :password)
  end

  def create_profile(user)
    name = user.email.split('@').first unless params[:accounts][:name]
    profile = Profile.new(name: params[:accounts][:name] || name, user_id: user.id)
    profile.save
  end
end
