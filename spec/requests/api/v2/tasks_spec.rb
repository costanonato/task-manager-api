require 'rails_helper'

RSpec.describe 'Task API' do
  before { host! 'api.taskmanager.dev' }

  let!(:user) { create(:user) }
  let!(:auth_data) { user.create_new_auth_token }
  let(:headers) do
		{
		  'Content-Type' => Mime[:json].to_s,
		  'Accept' => 'application/vnd.taskmanager.v2',
		  'access-token' => auth_data['access-token'],
		  'uid' => auth_data['uid'],
		  'client' => auth_data['client']
		}
  end


  describe 'GET /tasks' do
    context 'when no filter param is sent' do
      before do
        create_list(:task, 5, user_id: user.id)
        get '/tasks', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 tasks from database' do
        expect(json_body[:data].count).to eq(5)
      end      
    end


    context 'when filter and sorting params are sent' do
      let!(:notebook_task_1) { create(:task, title: 'Check if the notebook is broken', user_id: user.id) }
      let!(:notebook_task_2) { create(:task, title: 'Buy a new notebook', user_id: user.id) }
      let!(:other_task_1) { create(:task, title: 'Fix the door', user_id: user.id) }
      let!(:other_task_2) { create(:task, title: 'Buy a new car', user_id: user.id) }

      before do
        get '/tasks?q[title_cont]=note&q[s]=title+ASC', params: {}, headers: headers
      end

      it 'returns only the tasks matching and in the correct order' do
        returned_task_titles = json_body[:data].map { |t| t[:attributes][:title] }

        expect(returned_task_titles).to eq([notebook_task_2.title, notebook_task_1.title])
      end
    end
  end


  describe 'GET /tasks/:id' do
    let(:task) { create(:task, user_id: user.id) }

    before { get "/tasks/#{task.id}", params: {}, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for task' do
      expect(json_body[:data][:attributes][:title]).to eq(task.title)
    end
  end


  describe 'POST /tasks' do
    before do
      post '/tasks', params: { task: task_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:task_params) { attributes_for(:task) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'saves the task in the database' do
        expect( Task.find_by(title: task_params[:title]) ).not_to be_nil
      end

      it 'returns the json for created task' do
        expect(json_body[:data][:attributes][:title]).to eq(task_params[:title])
      end

      it 'assigns the created task to the current user' do
        expect(json_body[:data][:attributes][:'user-id']).to eq(user.id)
      end      
    end

    context 'when the params are invalid' do
      let(:task_params) { attributes_for(:task, title: ' ') }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'does not save the task in the database' do
        expect( Task.find_by(title: task_params[:title]) ).to be_nil
      end

      it 'returns the json error for title' do
        expect(json_body[:errors]).to have_key(:title)
      end
    end
  end

  
  describe 'PUT /tasks/:id' do
    let!(:task) { create(:task, user_id: user.id) }

    before do
      put "/tasks/#{task.id}", params: { task: task_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:task_params){ { title: 'New task title' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json for updated task' do
        expect(json_body[:data][:attributes][:title]).to eq(task_params[:title])
      end

      it 'updates the task in the database' do
        expect( Task.find_by(title: task_params[:title]) ).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:task_params){ { title: ' '} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json error for title' do
        expect(json_body[:errors]).to have_key(:title)
      end

      it 'does not update the task in the database' do
        expect( Task.find_by(title: task_params[:title]) ).to be_nil
      end
    end
  end


  describe 'DELETE /tasks/:id' do
    let!(:task) { create(:task, user_id: user.id) }

    before do
      delete "/tasks/#{task.id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the task from the database' do
      expect { Task.find(task.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

end