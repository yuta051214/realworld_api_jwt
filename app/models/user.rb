# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :username, :email, :password, presence: true
  validates :email, :username, uniqueness: true, on: :create

  # has_many :articles, dependent: :destroy

  #* as_jsonメソッドをオーバーライドして、UserオブジェクトをJSON形式にシリアライズする際にカスタマイザされた形式で出力するようにしている。
  def as_json(options = {})
    super(options.merge(only: [:email, :username, :bio, :image]))
  end
end
