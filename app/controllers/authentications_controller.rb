class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request, raise: false

  def login
    @user = User.find_by_email(user_params[:email])

    if @user&.authenticate(user_params[:password])
      # user.id を基にJWTを生成
      @user_token = JsonWebToken.encode(user_id: @user.id)
      # レスポンスに token をマージして送る
      render json: @user.as_json.merge({ token: @user_token }), status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
