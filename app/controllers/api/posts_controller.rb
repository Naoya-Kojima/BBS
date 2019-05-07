class Api::PostsController < ApplicationController

  def index
    posts = Post.all
    render json: posts
  end

  def show
    post = Post.find(params[:id])
    # comments = post.comments.all.order(id: "DESC").includes([:user])
    render json: post
  end

end
