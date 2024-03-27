class UserService
    def get()
        User.all
    end

    def get_by_id(id)
        set_user(id) 
        @user 
    end

    def create(params)
        password_digest = BCrypt::Password.create(params[:password])
        @user = User.new(user_params(params).merge(password_digest: password_digest))
    end
    
    def update(params)
        set_user(params[:id]) 
        @user.update(user_params(params))
        @user
    end

    def get_by_name(name)
        User.find_by(name: name)
    end
    
    def destroy(params)
        set_user(params[:id]) 
        @user.destroy
    end

    def authenticate_user(token)
        if token && token.start_with?('Bearer ')
          token = token.slice(7..-1)
          decoded_token = JsonWebTokenService.decode(token)
          return User.find_by(id: decoded_token[:user_id])
        end
        return nil
    end

    private

    def set_user(id)
    @user = User.find(id)
    end

    def user_params(params)
        params.require(:user).permit(:name, :password, :email)
    end
end