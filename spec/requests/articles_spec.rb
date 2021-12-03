# Test the responsibilities of controller

require 'rails_helper'

require 'rails_helper'

RSpec.describe 'ArticlesControllers', type: :request do
  
  # before(:each) do 
  #   Article.destroy_all
  #   Article.create!(name:'A valid article name', body:'A valid article body')
  # end

  let(:article) { Article.create!(name:'A valid article name', body:'A valid article body') }

  describe 'GET /index' do
    it 'returns the index page' do
      get articles_path
      expect(response).to be_successful
      # expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it 'shows the article details' do
      # get article_path(article)
      get "/articles/#{article.id}"
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'can create a article' do
        get new_article_path
        expect(response).to be_successful
        # expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    it 'creates an article with valid attributes' do
      expect do
        post articles_path, params: { article: {name:'New article', body:'New article body'}}
      end.to change(Article, :count).by(1)
      # expect(response).to be_successful
      # expect(response).to have_http_status(:created)
    end  
  end

  describe 'GET /edit' do
    it 'redirects to edit page' do
      get edit_article_path(article)
      # get '/articles/#{article.id}/edit'
      expect(response).to be_successful
      # expect(response).to render_template(:edit)
    end

    it 'updates the category' do

      patch article_path(article), params: { article: {name:'updated name', body:'A valid article body'}}
      expect(Article.last.name).to eq('updated name')
      #   patch '/articles/#{article.id}', params: { article: {name:'updated name', body:'A valid article body'} } 
      # expect(response).to be_successful
    end
  end
end


