require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:quest) { Question.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false) }  

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "should render #index view" do
      get :index
      expect(response).to render_template(:index)
    end
    
    it "should assign [quest] to @questions" do
      get :index
      expect(assigns(:questions)).to eq([quest])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: quest.id}
      expect(response).to have_http_status(:success)
    end
    
    it "should render #show view" do
      get :show, {id: quest.id}
      expect(response).to render_template(:show)
    end
    
    it "should assign quest to @question" do
      get :show, {id: quest.id}
      expect(assigns(:question)).to eq(quest)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "should render #new view" do
      get :new
      expect(response).to render_template(:new)
    end
    
    it "should instantiate @question" do 
      get :new
      expect(assigns(:question)).not_to be_nil
    end
  end
  
  describe "POST #create" do
    it "should increase the number of Question by 1" do
      expect{post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}}
    end
    
    it "should assign the new question to @question" do
      post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}
      expect(assigns(:question)).to eq(Question.last)
    end
    
    it "should redirect to the new question" do
      post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}
      expect(response).to redirect_to(Question.last)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: quest.id}
      expect(response).to have_http_status(:success)
    end
    
    it "should render #edit view" do
      get :edit, {id: quest.id}
      expect(response).to render_template(:edit)
    end
    
    it "should assign question to be updated to @question" do
      get :edit, {id: quest.id}
      question_instance = assigns(:question)
      expect(question_instance.id).to eq quest.id
      expect(question_instance.title).to eq quest.title
      expect(question_instance.body).to eq quest.body
      expect(question_instance.resolved).to eq quest.resolved
    end
  end
  
  describe "PUT #update" do
    it "should update post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body  = RandomData.random_paragraph
      rand(0..1) == 0 ? new_resolved = false : new_resolved = true 
      put :update, id: quest.id, question: {title:new_title, body: new_body, resolved: new_resolved}
      updated_question = assigns(:question)
      expect(updated_question.id).to eq quest.id
      expect(updated_question.title).to eq new_title
      expect(updated_question.body).to eq new_body
      expect(updated_question.resolved).to eq new_resolved
    end
    
    it "should redirect to the updated post" do
      new_title = RandomData.random_sentence
      new_body  = RandomData.random_paragraph
      rand(0..1) == 0 ? new_resolved = false : new_resolved = true 
      put :update, id: quest.id, question: {title:new_title, body: new_body, resolved: new_resolved}
      expect(response).to redirect_to quest
    end
  end
  
  describe "DELETE #destroy" do
    it "should delete the question" do
      delete :destroy, {id: quest.id}
      count = Question.where({id: quest.id}).size
      expect(count).to eq 0
    end
    
    it "should redirect to questions index" do
      delete :destroy, {id: quest.id}
      expect(response).to redirect_to questions_path
    end
  end
end
