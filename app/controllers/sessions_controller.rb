# Assuming you have a User model
class SessionsController < ApplicationController

    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        token = JsonWebTokenService.encode(user_id: user.id)
        render json: { 
          user: user.name,
          email: user.email,
          token: token }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
  