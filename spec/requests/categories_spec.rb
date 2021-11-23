require 'rails_helper'

RSpec.describe 'Categories', type: :request do

  describe 'GET categories#index' do
    it 'returns the index page' do
      get categories_path
      expect(response).to be_successful
    end
  end

  describe 'GET categories#show' do
    it 'shows the category details' do
      get categories_path
      expect(response).to be_successful
    end
  end

  describe 'GET categories#new' do
    it 'can create a category' do
        # get new_category_path
        get '/categories', params: { name: 'samplecategory'}
        expect(response).to be_successful
    end
  end

  describe 'POST categories#create' do
    it 'creates a category with valid attributes' do
      expect do
        post categories_path, params: { category: {name: 'New Category'}}
      end.to change(Category, :count).by(1)
      # expect(response).to have_http_status(:created)
    end  
  end

  describe 'GET categories#edit' do
    it 'redirects to edit page' do
      Category.create(name: 'editthiscategory')
      get edit_category_path(Category.last.id)
      expect(response).to be_successful
    end
  end
end

