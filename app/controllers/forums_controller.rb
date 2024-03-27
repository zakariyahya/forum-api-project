require_relative '../services/users_service'
require_relative '../services/forums_service'
class ForumsController < ApplicationController
    before_action :user_service
    before_action :forum_service
    before_action :authenticate_user!

    # GET /forums
    def index
        @forums = @forum_service.get
        forums_with_users = @forums.map do |forum|
            {
                id: forum.id,
                name: forum.name,
                description: forum.description,
                users: forum.users.map { |user| { id: user.id, name: user.name } }
            }
        end
        render json: { forums: forums_with_users }
        # render json: @forums
    end
      
    # GET /users/1
    def show
        if forum
            forum_with_users = {
              id: forum.id,
              name: forum.name,
              description: forum.description,
              users: forum.users.map { |user| { id: user.id, name: user.name } }
            }
            render json: { forum: forum_with_users }
          else
            render json: { error: 'Forum not found' }, status: :not_found
          end
        # render json: @get_by_id
    end

     # GET /users/by_name/:name
    def get_by_name
        forum = @forum_service.get_by_name(params[:name])
        if forum
            render json: forum
        else
            render json: { error: "Forum not found" }, status: :not_found
        end
    end

    # POST /users
    def create
      @forum = @forum_service.create(params)

      if @forum.save
        render json: @forum, status: :created, location: @user
      else
        render json: @forum.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /users/1
    def update
      if @forum = @forum_service.update(params)
        render json: @forum
      else
        render json: @forum.errors, status: :unprocessable_entity
      end
    end

    # DELETE /users/1
    def destroy
        begin
            @forum_service.destroy(params)
            render json: { message: "Forum deleted successfully" }, status: :ok
          rescue ActiveRecord::RecordNotFound
            render json: { error: "Forum ID not found" }, status: :not_found
        end
    end

    private
    def forum_service
        @forum_service = ForumService.new
    end
    def user_service
        @user_service = UserService.new
    end

    def forum
        @forum = @forum_service.get_by_id(params[:id])
    end

    def authenticate_user!
        token = request.headers['Authorization']
        user = @user_service.authenticate_user(token)
        unless user
        render json: { error: 'Unauthorized. Missing or invalid token' }, status: :unauthorized
        end
    end
end
