 require 'rails_helper'

RSpec.describe "/tasks", type: :request do
    
    before(:each) do 
      Category.destroy_all
    end

    let(:category) { Category.create!(name: 'Category Title') }

    let(:task) { Task.create!(category_id: category.id,name: 'Task Details',body: 'Task Body Details',task_date: Date.current) }

      describe "GET /index" do
        it "renders a successful response" do
          get category_tasks_url(category)
          expect(response).to be_successful
        end
      end

      describe "GET /show" do
        it "renders a successful response" do
          get category_task_url(category.id, task)
          expect(response).to be_successful
        end
      end

      describe "GET /new" do
        it "renders a successful response" do
          get new_category_task_url(category.id)
          expect(response).to be_successful
        end
      end

      describe "POST /create" do
        it "creates a new task with valid parameters" do
          expect {
            post category_tasks_url(category.id), params: { task: { category_id:category.id, name:'A valid name', body:'A valid body', task_date:Date.current }}
          }.to change(Task, :count).by(1)
        end
    end

      describe "GET /edit" do
        it "render a successful response" do
          get edit_category_task_url(category.id, task)
          expect(response).to be_successful
        end
      end

      describe "PATCH /update" do 
        it "updates the requested task with valid parameters" do
          patch category_task_url(category.id, task), params: { task: { category_id:category.id, name:'Updated valid name', body:'A valid body', task_date:Date.current }}
          expect(Task.last.name).to eq('Updated valid name')
        end
      end

    describe "DELETE /destroy" do
      it "destroys the requested task" do
        expect do
          delete category_task_path(category.id, task.id)
        end.to change(Task, :count).by(0)
      end
    end
end
