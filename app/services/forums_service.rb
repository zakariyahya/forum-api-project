class ForumService
    def get()
        Forum.all
    end

    def get_by_id(id)
        set_forum(id) 
        @forum 
    end

    def create(params)
        @forum = Forum.new(forum_params(params))
    end
    
    def update(params)
        set_forum(params[:id]) 
        @forum.update(forum_params(params))
        @forum
    end

    def get_by_name(name)
        Forum.find_by(name: name)
    end
    
    def destroy(params)
        set_forum(params[:id]) 
        @forum.user_forums.destroy_all
        @forum.destroy
    end

    # def authenticate_user(token)
    #     if token && token.start_with?('Bearer ')
    #       token = token.slice(7..-1)
    #       decoded_token = JsonWebTokenService.decode(token)
    #       return User.find_by(id: decoded_token[:user_id])
    #     end
    #     return nil
    # end

    private

    def set_forum(id)
    @forum = Forum.find(id)
    end

    def forum_params(params)
        params.require(:forum).permit(:name, :description)
    end
end