require 'rails_helper'

RSpec.describe EvaluateAssetsController, type: :controller do

  let(:asset) { Asset.create(name: "test") }
  describe "GET #show" do
    it "returns http success" do
      get :show, params: {id: asset.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #update" do
    #it "returns http success" do
      #post :update
      #expect(response).to have_http_status(:success)
    #end
  end

end
