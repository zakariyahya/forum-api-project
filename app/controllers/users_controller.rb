require_relative '../services/users_service'
class UsersController < ApplicationController
    before_action :user_service
    before_action :authenticate_user!, except: [:create]

    # GET /users
    def index
        @users = @user_service.get
        users_with_forums = @users.map do |user|
            {
                id: user.id,
                name: user.name,
                forums: user.forums.map { |forum| { id: forum.id, name: forum.name } }
            }
        end
        render json: { users: users_with_forums }
    end
      
    # GET /users/1
    def show
        @get_by_id = @user_service.get_by_id(params[:id])
        render json: @get_by_id
    end

     # GET /users/by_name/:name
    def get_by_name
        user = @user_service.get_by_name(params[:name])
        if user
            render json: user
        else
            render json: { error: "User not found" }, status: :not_found
        end
    end

    # POST /users
    def create
      @user = @user_service.create(params)

      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @user = @user_service.update(params)
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
        begin
            @user_service.destroy(params)
            render json: { message: "User deleted successfully" }, status: :ok
          rescue ActiveRecord::RecordNotFound
            render json: { error: "User ID not found" }, status: :not_found
        end
    end

    private
    def user_service
        @user_service = UserService.new
    end

    def authenticate_user!
        token = request.headers['Authorization']
        user = @user_service.authenticate_user(token)
        unless user
        render json: { error: 'Unauthorized. Missing or invalid token' }, status: :unauthorized
        end
    end


#   def authenticate_user!
#     token = request.headers['Authorization']
#     decoded_token = JsonWebTokenService.decode(token)
#     unless decoded_token && User.exists?(decoded_token[:user_id])
#       render json: { error: 'Unauthorized' }, status: :unauthorized
#     end
#   end
# def authenticate_user!
#     token = request.headers['Authorization']
#     if token && token.start_with?('Bearer ')
#       token = token.slice(7..-1) # Menghapus kata "Bearer " dari token
#       decoded_token = JsonWebTokenService.decode(token)
#       unless decoded_token && User.exists?(decoded_token[:user_id])
#         render json: { error: 'Unauthorized' }, status: :unauthorized
#       end
#     else
#       render json: { error: 'Unauthorized. Missing or invalid token' }, status: :unauthorized
#     end
#   end
 
end
  