require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:my_post) { Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    
    it "should assign [my_post] to @posts" do
      get :index
      expect(assigns(:posts)).to eq([my_post])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    
    it "should render the #show view" do
      get :show, {id: my_post.id}
      expect(response).to render_template(:show)
    end
    
    it "should assign my_post to @post" do
      get :show, {id: my_post.id}
      expect(assigns(:post)).to eq(my_post)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "should render the #new view" do
      get :new
      expect(response).to render_template :new
    end
    
    it "should instantiate @post" do
      get :new
      expect(assigns(:post)).not_to be_nil
    end
  end
  
  describe "POST create" do
    it "should increase the number of Post by 1" do
      expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
    end
    
    it "should assign the new post to @post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:post)).to eq(Post.last)
    end
    
    it "should redirect to the new post" do
      post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to(Post.last)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: my_post.id}
      expect(response).to have_http_status(:success)
    end
    
    it "should render the #edit view" do
      get :edit, {id: my_post.id}
      expect(response).to render_template :edit
    end
    
    it "should assign post to be updated to @post" do
      get :edit, {id: my_post.id}
      post_instance = assigns(:post)
      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end
  
  describe "PUT update" do
    it "should update post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body  = RandomData.random_paragraph
      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      updated_post = assigns(:post)
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end
    
    it "should redirect to the updated post" do
      new_title = RandomData.random_sentence
      new_body  = RandomData.random_paragraph
      put :update, id: my_post.id, post: {title: new_title, body: new_body}
      expect(response).to redirect_to my_post
    end
  end
  
  describe "DELETE destroy" do
    it "should delete the post" do
      delete :destroy, {id: my_post}
      count = Post.where({id: my_post.id}).size
      expect(count).to eq 0
    end
    
    it "redirects to posts index" do
      delete :destroy, {id: my_post.id}
      expect(response).to redirect_to posts_path
    end
  end
end






















