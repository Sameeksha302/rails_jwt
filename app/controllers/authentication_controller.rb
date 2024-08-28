class AuthenticationController < ApplicationController
    before_action :authorize_request, except: %i[login signup]
  
    # POST /auth/login
    def login
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: @user.id)
        time = Time.now + 24.hours.to_i
        render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                       username: @user.username ,message: "login successfully"}, status: :ok
      else
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end


    def signup
        @user = User.new(signup_params)
        # if @user.save
        #   token = JsonWebToken.encode(user_id: @user.id)
        #   time = Time.now + 24.hours.to_i
        #   render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"), username: @user.username }, status: :ok
        # else
        #   render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        # end
        if @user.save
            render json: { message: 'User created successfully' }, status: :ok
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def logout
        # Here you might want to perform client-side actions, like clearing the token from storage
        render json: { message: 'Signed out successfully' }, status: :ok
    end
    
  
    private
  
    def login_params
      params.permit(:email, :password)
    end
    def signup_params
        params.permit(:name, :username, :email, :password, :password_confirmation)
    end
end