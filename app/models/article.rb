class Article < ApplicationRecord
  before_save :generate_slug

  validates :title, :description, :body, presence: true
  validates :title, uniqueness: true, on: :create

  belongs_to :user

  # json レスポンスをカスタマイズ
  def as_json(options = {}, current_user = nil)
    super(options.merge(except: [:id, :user_id])).merge({
      author: user
    })
  end

  private

  def generate_slug
    self.slug = self.title.parameterize    # parameterize: 大文字を小文字に、空白をハイフンに変換
  end

end
