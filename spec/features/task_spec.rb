require 'rails_helper'

RSpec.describe 'Task', type: :feature do
    
    before(:each) do
        Category.destroy_all
    end

    let!(:category) { Category.create(name: 'A valid name') }
    let!(:task) { category.tasks.create(name:'A valid task name', body:'A valid task body', task_date: Date.current) }

    describe 'View all Tasks' do
        before { visit categories_path }
        it 'shows all tasks' do
            # visit categories_path
            visit '/categories/Category.last.id'
            click_on 'Show'
            expect(page).to have_content 'ALL TASKS'
            expect(page).to have_content 'New Task'
        end
    end

    describe 'Create a new Task' do
        # before { visit new_category_task_path }
        it 'Successfully create new task' do
            # visit new_category_task_path
            visit '/categories/1/tasks/new'
            expect(page).to have_content 'New Task'
            click_on 'New Task'
        
            expect(page).to have_current_path '/categories/1/tasks/new'
            within 'form' do
                fill_in 'name', :with => 'Sample name'
                fill_in 'body', :with => 'Sample body'
                fill_in 'task_date', :with => Date.current
                expect { click_on 'Create task' }.to change(Task, :count).by(1) 
                expect(page).to have_content('Task was successfully created')
             end
        end
    end

    describe 'Edit a task to update task details' do
        it 'Successfully updates the task' do
            # visit edit_category_task_path(1, 1)
            visit "/categories/1/tasks/1/edit"
            fill_in 'task_name', :with => 'Updated task name'
            fill_in 'task_name', :body => 'Updated task body'
            click_on 'Edit'
            expect(page).to have_content('Updated task name')
            expect(page).to have_content('Updated task body')
            expect(page).to have_content('Task was successfully updated')
        end
    end    

    
    describe 'delete a task' do
        it 'Successfully destroys the task' do
            # visit category_path(1)
            visit "/categories/1/tasks/1"
            # click_on ('Delete')
            expect { click_on 'Delete' }.to change(Task, :count).by(-1)
            expect(page).to have_content('Task was successfully deleted')
        end
    end

    describe 'view priority tasks for today' do
        it 'Successfully display tasks on current day' do
            # visit category_path(1)
            visit "/categories/1/tasks/1"
            expect(page).to have_content('TASKS FOR TODAY')
        end
    end
end