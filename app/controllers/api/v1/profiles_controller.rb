class Api::V1::ProfilesController < ApplicationController

  def index 
    @profile = Profile.find_by(user_id: @current_user.id)
    if @profile.present?
      post = @profile.user.posts
      render json: @profile, each_serializer: ProfileSerializer, status: :ok
    else
      render json: { 'message' => @profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_profile
    @profile = Profile.find_by(user_id: @current_user.id)
    if @profile.update(update_params)
      render json: { 'message' => 'Successfully updated!'}, status: :ok
    else
      render json: { 'message' => @profile.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_profile_photo
    @profile = Profile.find_by(user_id: @current_user.id)
    if @profile.photo.attach(params[:photo])
      render json: { message: 'Profile photo updated' }, status: :ok
    else
      render json: { message: 'Failed to update profile picture' }, status: :unprocessable_entity
    end
  end

  private
  def update_params
    params.permit(:name, :username, :bio, :website)
  end
end
