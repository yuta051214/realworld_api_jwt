# frozen_string_literal: true

require 'jwt'

#* JsonWebToken モジュール (ここで jwt gem を require し、新たに２つのメソッドを定義している)
module JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  #* payload(user.idが入る) と expires を引数として受け取り、JWTを生成する。
  def self.encode(payload, exp = 48.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  #* JWT を引数として受け取り、デコードして payload を返す。
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded         # HashWithIndifferentAccess オブジェクトに変換
  end
end
