require 'rails_helper'

RSpec.describe Article, type: :model do

    let!(:article) {Article.new}

    context 'Article Validations' do
        
        it '1. Is not valid without a name' do
            article.body = "Sample body"
            article.name = nil

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_h.keys).to include(:name)
        end


        it '2. Is not valid without a body' do
            article.name = "Sample name"
            article.body = nil

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_h.keys).to include(:body)
        end

        it '3. Creates a new article if attributes are valid' do
            article_count = Article.count
            article.name = "name"
            article.body = "a valid body"

            article.save!
            expect(Article.count).to eq(1)
        end

        it '4. Has a body with at least 10 characters long' do
            article = Article.new(name: 'Sample name', body: '')
            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_h.keys).to include(:body)
            
            article.body = 'a valid body'
            expect(article).to be_valid
        end

        it '5. Should have a unique name' do
        # it '5. Should validate_uniqueness_of(:name).ignoring_case_sensitivity' do
            Article.create!(:name=>'sample',:body=>'a valid body')
            article = Article.new(:name=>'sample',:body=>'a valid body')
            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_h.keys).to include(:name)
            # article.errors[:name].should include('has already been taken')

            article.name = 'sampler'
            expect(article).to be_valid
        end
    end
end