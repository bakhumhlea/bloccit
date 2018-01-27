require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  
  let(:an_ads) { Advertisement.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [an_ads] to @advertisements" do
      get :index
      expect(assigns(:advertisements)).to eq([an_ads])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: an_ads.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #show view" do
        get :show, {id: an_ads.id}
        expect(response).to render_template :show
    end
    
    it "assigns an_ads to @advertisement" do
        get :show, {id: an_ads.id}
        expect(assigns(:advertisement)).to eq(an_ads)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the #new view" do
        get :new
        expect(response).to render_template :new
    end
    
    it "instantiates @advertisement" do
        get :new
        #assigns gives us access to the @advertisement variable
        expect(assigns(:advertisement)).not_to be_nil
    end
  end

  describe "ADS create" do
      it "increases the number of Ads by 1" do
          expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price}}.to change(Advertisement,:count).by(1)
      end
   
      it "assigns the new ads to @ads" do
          post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price}
          expect(assigns(:ads)).to eq Advertisement.last
      end
   
      it "redirects to the new created Ads" do
          post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: RandomData.random_price}
          expect(response).to redirect_to Advertisement.last
      end
  end

end
