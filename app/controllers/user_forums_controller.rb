require_relative '../services/users_forums_service'
require_relative '../services/users_service'

class UserForumsController < ApplicationController
    before_action :user_service
    before_action :user_forum_service
    before_action :authenticate_user!, except: [:create]

    # GET /user_forums
    def index
        @user_forums = @user_forum_service.get
        render json: @user_forums
    end
      
    # GET /user_forums/1
    def show
        @get_by_id = @user_forum_service.get_by_id(params[:id])
        render json: @get_by_id
    end

     # GET /user_forums/by_name/:name
    def get_by_name
        user_forum = @user_forum_service.get_by_name(params[:name])
        if user_forum
            render json: user_forum
        else
            render json: { error: "User Forum not found" }, status: :not_found
        end
    end

    # POST /user_forums
    def create
      @user_forum = @user_forum_service.create(params)

      if @user_forum.save
        render json: @user_forum, status: :created, location: @user_forum
      else
        render json: @user_forum.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /user_forums/1
    def update
      if @user_forum = @user_forum_service.update(params)
        render json: @user_forum
      else
        render json: @user_forum.errors, status: :unprocessable_entity
      end
    end

    # DELETE /user_forums/1
    def destroy
        begin
            @user_forum_service.destroy(params)
            render json: { message: "User Forum deleted successfully" }, status: :ok
          rescue ActiveRecord::RecordNotFound
            render json: { error: "User Forum ID not found" }, status: :not_found
        end
    end

    private
    def user_forum_service
        @user_forum_service = UserForumService.new
    end

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
end
