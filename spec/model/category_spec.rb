require 'rails_helper'

RSpec.describe Category, type: :model do
  
  let!(:category) {Category.new}

    context 'Category validation tests' do

        it '1. As a user, I want to create a category that can be used to organize my task' do
          category_count = Category.count
          category.name = 'samplecategory1'
          
          category.save!
          expect(Category.count).to eq(1)
        end
    
        it '2. should validate presence of name' do
          category = Category.new(name: '').save
          expect(category).to eq(false)
          # post.valid?
          # expect(category.errors.messages[:name]).include("can't be blank")
        end

        it '3. As A User, I want to view a category to show the category details' do
          category.name = 'samplecategory1'
          expect(category.name).to eq('samplecategory1')
        end

        it '4. As a User, I want to edit a category to update the category details' do
            category = Category.create!(name:'samplecategory1')
            category.update!(name:'updatedsamplecategory1')
            expect(category.name).to eq('updatedsamplecategory1')
            expect(category).to be_valid
        end
      end
end