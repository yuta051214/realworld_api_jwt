class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authorize_request

  #* リクエストに対する認証：クライアントから送信されたJWTを検証し、＠current_userに代入する。
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound
      render_unauthorized
    rescue JWT::DecodeError
      render_unauthorized
    end
  end

  #* 対象の記事が、ログイン中のユーザのものかどうか( update, destroy アクションで使用する )
  def owner?(article)
    article.user_id == @current_user.id
  end

  def render_unauthorized
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end
