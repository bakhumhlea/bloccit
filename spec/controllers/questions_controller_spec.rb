require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  
  let(:my_ques) { Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph,resolved: false) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_ques] to @questions" do
      get :index
      expect(assigns(:questions)).to eq([my_ques])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_ques.id}
      expect(response).to have_http_status(:success)
    end
    it "render the #show view" do
      get :show, {id: my_ques.id}
      expect(response).to render_template :show
    end
    it "assigns my_ques to @question" do
      get :show, {id: my_ques.id}
      expect(assigns(:question)).to eq(my_ques)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "render the #new view" do
      get :new
      expect(response).to render_template :new
    end
    it "instantiates a new question" do
      get :new
      expect(assigns(:question)).not_to be_nil
    end
  end
  
  describe "QUESTION create" do
    it "increases the number of Question by 1" do
      expect{post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}}.to change(Question,:count).by(1)
    end
 
    it "assigns the new question to @question" do
      post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}
      expect(assigns(:question)).to eq(Question.last)
    end
 
    it "redirects to the new question" do
       post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}
      expect(response).to redirect_to Question.last
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: my_ques.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the #edit view" do
      get :edit, {id: my_ques.id}
      
      expect(response).to render_template :edit
    end
     
    it "assigns question to be updated to @question" do
      get :edit, {id: my_ques.id}
      
      ques_instance = assigns(:question)
      
      expect(ques_instance.id).to eq my_ques.id
      expect(ques_instance.title).to eq my_ques.title
      expect(ques_instance.body).to eq my_ques.body
    end
  end
  
  describe "PUT update" do
    it "updates question with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      
      put :update, id: my_ques.id, question: {title: new_title, body: new_body, resolved: false }
      
      
      updated_ques = assigns(:question)
      expect(updated_ques.id).to eq(my_ques.id)
      expect(updated_ques.title).to eq(new_title)
      expect(updated_ques.body).to eq(new_body)
    end
    
    it "redirects to the updated question" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      
      
      put :update, id: my_ques.id, question: {title: new_title, body: new_body, resolved: false}
      expect(response).to redirect_to my_ques
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the question" do
      delete :destroy, {id: my_ques.id}
      count = Question.where({id: my_ques.id}).size
      expect(count).to eq 0
    end
    
    it "redirects to questions index" do
      delete :destroy, {id: my_ques.id}
      
      expect(response).to redirect_to questions_path
    end
  end

end
