require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  
  describe "GET #index" do
    it "should return http success" do 
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "should render the #index view" do
      get :index
      expect(response).to render_template(:index)
    end
    
    it "should assign my_topic to @topics" do
      get :index
      expect(assigns(:topics)).to eq([my_topic])
    end
  end
  
  describe "GET #show" do
    it "should return http succes" do
      get :show, {id: my_topic.id}
      expect(response).to have_http_status(:success)
    end
    
    it "should render the #show view" do
      get :show, {id: my_topic.id}
      expect(response).to render_template(:show)
    end
    
    it "should assign my_topic to @topic" do
      get :show, {id: my_topic.id}
      expect(assigns(:topic)).to eq(my_topic)
    end
  end
  
  describe "GET #new" do
    it "should return http succes" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "should render the #new view" do
      get :new
      expect(response).to render_template(:new)
    end
    
    it "should instantiate @topic" do
      get :new
      expect(assigns(:topic)).not_to be_nil
    end
  end
  
  describe "POST create" do
    it "should increase the number of topics by 1" do 
      expect{ post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}}.to change(Topic,:count).by(1)
    end
    
    it "should assign Topic.last to @topic" do
      post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
      expect(assigns(:topic)).to eq(Topic.last)
    end
    
    it "should redirect to the new topic" do
      post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
      expect(response).to redirect_to(Topic.last)
    end
  end
  
  describe "GET #edit" do
    it "should report http success" do
      get :edit, {id: my_topic.id} 
      expect(response).to have_http_status(:success)
    end
    
    it "should render the #edit view" do
      get :edit, {id: my_topic.id}
      expect(response).to render_template(:edit)
    end
    
    it "should assign topic to be updated to @topic" do
      get :edit, {id: my_topic.id}
      topic_instance = assigns(:topic)
      
      expect(topic_instance.id).to eq(my_topic.id)
      expect(topic_instance.name).to eq(my_topic.name)
      expect(topic_instance.description).to eq(my_topic.description)
    end
  end
  
  describe "PUT update" do
    it "should update topic with expected attributes" do
      new_name = RandomData.random_sentence
      new_description = RandomData.random_paragraph
      put :update, id: my_topic.id, topic: { name: new_name, description: new_description }
      updated_topic = assigns(:topic)
      
      expect(updated_topic.id).to eq(my_topic.id)
      expect(updated_topic.name).to eq(new_name)
      expect(updated_topic.description).to eq(new_description)
    end
    
    it "should redirect to the update topic" do
      new_name = RandomData.random_sentence
      new_description = RandomData.random_paragraph
      put :update, id: my_topic.id, topic: { name: new_name, description: new_description }

      expect(response).to redirect_to(my_topic)
    end
  end
  
  describe "DELETE destroy" do
    it "deletes the topic" do
      delete :destroy, {id: my_topic.id}
      count = Topic.where({id: my_topic.id}).size
      
      expect(count).to eq(0)
    end
    
    it "should redirect to topics index" do
      delete :destroy, {id: my_topic.id}
      expect(response).to redirect_to topics_path
    end
  end
end
