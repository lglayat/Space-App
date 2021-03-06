class UsersController < ApplicationController

  skip_before_action :authorized, only: [:create]
  # I AM CREATING A User
  def create
    user = User.new(username: params[:username], password: params[:password])
    if user.save
      token = encode_token({ user_id: user.id})
      render json: {user: user, jwt: token}
    else
    end
  end

  def show
  	# @user = User.find_by(id: params[:id])
    if @user
      render json: { curiosities: @user.curiosities}
    else
      render json: { message: "Error"}
    end

  end

  def addLike

    # @user = User.find_by(id: params[:id])
    @curiosity = Curiosity.find_by(id: params[:picture_id])


    if @user && @curiosity 
      @user.curiosities.push(@curiosity)
      render json: { user: @user }
    else 
      render json: { message: "Error"}
    end
  end

  def removeLike

    @curiosity = Curiosity.find_by(id: params[:picture_id])
    @user.curiosities.delete(@curiosity)

  end



end
