require 'rails_helper'

RSpec.describe 'Articles', type: :feature do

    before do
        sign_in create(:user)
        Article.destroy_all
        Article.create!(name:'Sample name', body:'Sample body')
    end

    after(:all) do
        User.destroy_all
    end

    # let(:article) { Article.create!(name:'Sample name', body:'Sample body') }

    describe 'View all Articles' do
        
        it 'shows all article in index page' do
            visit articles_path
            expect(page).to have_content 'All Articles'
            expect(page).to have_content 'New Article'
        end
    end

    # describe 'Create new Article' do
    #     before { visit articles_path }
    #     it 'Successfully create new article' do
    #     #    visit articles_path
    #             expect(page).to have_content 'New Article'
    #             click_button 'New Article'
    #             expect(page).to have_current_path new_article_path
    #             # expect(response).to redirect_to(new_article_path)
    #             expect(page).to have_content 'Create New Article'
   
    #             within 'form' do
    #                 fill_in 'Name', with: 'Sample name'
    #                 fill_in 'Body', with: 'Sample body'
    #                 click_button 'Create new article'
    #             end
    #         expect(page).to have_current_path articles_path
    #     end
    # end
end

