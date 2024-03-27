class UserForumService
    def get()
        UserForum.all
    end

    def get_by_id(id)
        set_user_forum(id) 
        @user_forum 
    end

    def create(params)
        @user_forum = UserForum.new(user_forum_params(params))
    end
    
    def update(params)
        set_user_forum(params[:id]) 
        @user_forum.update(user_forum_params(params))
        @user_forum
    end

    def get_by_name(name)
        UserForum.find_by(name: name)
    end
    
    def destroy(params)
        set_user_forum(params[:id]) 
        @user_forum.destroy
    end

    private

    def set_user_forum(id)
    @user_forum = UserForum.find(id)
    end

    def user_forum_params(params)
        params.require(:user_forum).permit(:user_id, :forum_id)
    end
end