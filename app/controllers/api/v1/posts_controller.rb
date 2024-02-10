class Api::V1::PostsController < ApplicationController

  def index
    @posts = @current_user&.posts 
      if @posts.present?
        render json: @posts, each_serializer: PostSerializer, status: :ok
      else
        render json: { 'messages' => 'No posts yet' }, status: :not_found
      end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = @current_user&.id
    if params[:photos]
      @post.photos.attach(params[:photos]) 
    end
    if @post.save
      render json: { message: 'Successfully created', post: PostSerializer.new(@post).serializable_hash }, status: :created
    else
      render json: { 'error' => @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def post_params
    params.permit(:desc)
  end
end
