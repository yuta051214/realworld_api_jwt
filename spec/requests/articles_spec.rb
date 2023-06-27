require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let!(:article) { FactoryBot.create(:article, user: user) }
  let(:headers) { authenticated_header(user) }

  describe '一覧: GET /articles' do
    it 'returns a success response' do
      get articles_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe '詳細: GET /articles/:slug' do
    it 'returns a success response' do
      get article_path(article.slug)
      expect(response).to have_http_status(:ok)
      expect(article.title).to eq('How to train your dragon')
    end
  end

  describe '投稿: POST /articles' do
    let(:valid_attributes) do
      { title: 'Sample Article', description: 'Article Description', body: 'Some text for the article body' }
    end

    context 'when the request is valid' do
      before { post articles_path, params: { article: valid_attributes }, headers: headers }

      it 'creates a new article' do
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe '更新: PUT /articles/:slug' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'New Title' } }

      it 'updates the requested article' do
        put article_path(article.slug), params: { article: new_attributes }, headers: headers
        article.reload
        expect(response).to have_http_status(:ok)
        expect(article.title).to eq('New Title')
      end
    end
  end

  describe '削除: DELETE /articles/:slug' do
    it 'destroys the requested article' do
      expect {
        delete article_path(article.slug), headers: headers
      }.to change(Article, :count).by(-1)
    end
  end
end
