class Api::V1::CommentsController < ApplicationController

  def index
    @post = Post.find(params[:comment][:post_id])
    @comments = @post.comments
    if @comments.empty?
      render json: { "message" => "No comments yet" }, status: :not_found
    else
      render json: @comments, each_serializer: CommentSerializer, status: :ok
    end
  end

  def create
    @post = Post.find(params[:comments][:post_id])
    @comment = @post.comments.create(comment_params)
    
    if @comment
      render json: { "comment" => @comment }, status: :created
    end
  end

  private
  def comment_params
    params.require(:comments).permit(:body, :post_id)
  end
end
