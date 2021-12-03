require 'rails_helper'

RSpec.describe Article, type: :model do
    # pending "add some examples to (or delete) #{__FILE__}"
    
    before(:each) do 
        Article.destroy_all 
    end

    let!(:article) {Article.new}

    context 'Article Validations' do
        
        it '1. Is not valid without a name' do
            article.body = "A valid body"
            article.name = nil

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:name)
        end

        it '2. Should validate uniqueness of name' do
            article.name = 'A valid name'
            article.body = 'A valid body'
            article.save!
            
            new_article = Article.new(:name=>'A valid name',:body=>'A valid body')
            
            expect(new_article).to_not be_valid
            expect(new_article.errors).to be_present
            expect(new_article.errors.to_hash.keys).to include(:name)
           
            new_article.name = 'Unique name'
            expect(new_article).to be_valid
        end


        it '3. Is not valid without a body' do
            article.name = "A valid body"
            article.body = nil

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:body)
        end

        it '4. Creates a new article if attributes are valid' do
            article_count = Article.count
            article.name = "A valid name"
            article.body = "A valid body"
            article.save!
            
            expect(Article.count).to eq(1)
        end

        it '5. Has a body with at least 10 characters long' do
            article.name = 'A valid name'
            article.body = 'invalid'

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:body)
            
            article.body = 'a valid body'
            expect(article).to be_valid
        end
    end
end