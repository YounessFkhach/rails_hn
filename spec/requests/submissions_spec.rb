require 'rails_helper'

RSpec.describe 'Submissions API', type: :request do
  # initialize test data 
  let!(:user) { create(:user) }
  let!(:submissions) { create_list(:submission, 20, user_id: user.id) }
  let(:submission_id) { submissions.first.id }
  let(:user_id) { user.id }
  let(:headers) { valid_headers }


  # Test suite for GET /users
  describe 'GET /users/:user_id/submissions' do
    # make HTTP get request before each example
    before { get "/users/#{user_id}/submissions", headers: headers  }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo submissions' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

    # Test suite for GET /users/:id
  describe 'GET /users/:user_id/submissions/:id' do
    before { get "/users/#{user_id}/submissions/#{submission_id}", headers: headers  }

    context 'when user submission exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the submission' do
        expect(json['id']).to eq(submission_id)
      end
    end

    context 'when user submission does not exist' do
      let(:submission_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Submission/)
      end
    end
  end

  describe 'POST /users/:user_id/submissions' do
    let(:valid_attributes) { { title: 'Rails Tutorial', link: 'https://www.google.com' }.to_json }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/submissions", params: valid_attributes, headers: headers  }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/submissions", params: { title: "Bootcamp" }.to_json, headers: headers  }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Link can't be blank/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/submissions/:id
  describe 'PUT /users/:user_id/submissions/:submission_id' do
    let(:valid_attributes) { { title: 'Fake news', link: "https://theonion.org/" }.to_json }

    before { put "/users/#{user_id}/submissions/#{submission_id}", params: valid_attributes, headers: headers  }

    context 'when submissions exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the submission' do
        updated_submission = Submission.find(submission_id)
        expect(updated_submission.title).to match(/Fake news/)
      end
    end

    context 'when the submission does not exist' do
      let(:submission_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Submission/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/submissions/#{submission_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end