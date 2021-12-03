require 'rails_helper'

RSpec.describe 'Articles', type: :feature do
    
    describe 'View all Articles' do
        before { visit articles_path }

        it 'shows all article in index page' do
            within 'body' do
                expect(page).to have_content 'All Articles'
                expect(page).to have_content 'New Article'
            end
        end
    end

    describe 'Create new Article' do
        before { visit articles_path }

        it 'Successfully create new article' do
            within 'body' do
                expect(page).to have_content 'New Article'

                click_on 'New Article'
            end
            expect(page).to have_current_path new_article_path
                within 'form' do
                    fill_in 'article_name', with: 'Sample name'
                    fill_in 'article_body', with: 'Sample body'
                    click_on 'Save'
                end
            expect(page).to have_current_path articles_path
        end
    end
end

