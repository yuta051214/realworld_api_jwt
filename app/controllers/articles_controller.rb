class ArticlesController < ApplicationController
  skip_before_action :authorize_request, only: [:index, :show], raise: false
  before_action :set_article!, only: %i[show update destroy]

  def index
    @articles = Article.order(created_at: :desc).includes(:user)

    render_articles
  end

  def show
    render_article(status: :ok)
  end

  def create
    @article = @current_user.articles.new(article_params)

    if @article.save
      render_article(status: :created)
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def update
    unless owner?(@article)
      render_unauthorized and return
    end

    if @article.update(article_params)
      render_article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    unless owner?(@article)
      render_unauthorized and return
    end

    @article.destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body)
  end

  def set_article!
    @article = Article.find_by_slug(params[:slug])
  end

  def render_article(status: :ok)
    render json: { article: @article.as_json({}, @current_user) }, status: status
  end

  def render_articles
    render json: { articles: @articles, articlesCount: @articles.count }, status: :ok
  end

end
