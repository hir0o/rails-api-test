require 'rails_helper'

RSpec.describe "UsersApis", type: :request do
  describe "GET /users" do
    before do
      create_list(:user, 10)
    end
    it 'ユーザー一覧が表示されること' do
      get "/users"
      expect(response.status).to eq(200)
      expect(json.length).to eq(User.count)
    end
  end

  describe "GET /users/1" do
    before do
      @user = create(:user)
    end
    it 'ユーザーの詳細が表示されること' do
      get "/users/#{@user.id}"
      expect(response.status).to eq(200)
      expect(json['name']).to eq(@user.name)
    end
  end

  describe "POST /users" do
    before do
      @user_create_params = {
        user: {
          name: "user_name"
        }
      }
    end
    it 'ユーザーが作成されること' do
      expect do
        post "/users", params: @user_create_params
        expect(response.status).to eq(201)
      end.to change {User.count}.by(1)
    end
  end

  describe "PUT /users/1" do
    before do
      @user = create(:user)
      @user_update_params = {
        user: {
          name: "new_user_name"
        }
      }
    end
    it 'ユーザーが更新されること' do
      put "/users/#{@user.id}", params: @user_update_params
      expect(response.status).to eq(200)
      expect(@user.reload.name).to eq(@user_update_params[:user][:name])
    end
  end

  describe "DELETE /users/1" do
    before do
      @user = create(:user)
    end

    it 'ユーザーが削除されること' do
      expect do
        delete "/users/#{@user.id}"
        expect(response.status).to eq(204)
      end.to change{ User.count }.by(-1)
    end
  end
end
