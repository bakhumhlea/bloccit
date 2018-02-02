require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  
    let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
    
    let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
   
    describe "GET show" do
        
        it "returns http success" do
            ##get :show, {id: my_post.id}
            get :show, topic_id: my_topic.id, id: my_post.id
            expect(response).to have_http_status(:success)
        end
        
        it "renders the #show view" do
            ##get :show, {id: my_post.id}
            get :show, topic_id: my_topic.id, id: my_post.id
            expect(response).to render_template :show
        end
        
        it "assigns my_post to @post" do
            ##get :show, {id: my_post.id}
            get :show, topic_id: my_topic.id, id: my_post.id
            expect(assigns(:post)).to eq(my_post)
        end
        
    end
    
    describe "GET new" do
        it "returns http success" do
            ##get :new
            get :new, topic_id: my_topic.id
            expect(response).to have_http_status(:success)
        end
        
        it "renders the #new view" do
            ##get :new
            get :new, topic_id: my_topic.id
            expect(response).to render_template :new
        end
        
        it "instantiates @post" do
            ##get :new
            get :new, topic_id: my_topic.id
            #assigns gives us access to the @post variable
            expect(assigns(:post)).not_to be_nil
        end
    end
    
    describe "POST create" do
        it "increases the number of Post by 1" do
            ##expect{post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
            expect{post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Post,:count).by(1)
        end
     
        it "assigns the new post to @post" do
            ##post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
            post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
            expect(assigns(:post)).to eq Post.last
        end
     
        it "redirects to the new post" do
            ##post :create, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
            ##expect(response).to redirect_to Post.last
            post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
            expect(response).to redirect_to [my_topic, Post.last]
            ##because the route for the posts show view will also be updated to reflect nested 
            ##posts, instead of redirecting to  Post.last, we redirect to [my_topic, Post.last].
            ##Rails' router can take an array of objects and build a route to the show page of 
            ##the last object in the array, nesting it under the other objects in the array.
        end
    end

    describe "GET edit" do
        it "returns http success" do
            ##get :edit, {id: my_post.id}
            get :edit, topic_id: my_topic.id, id: my_post.id
            expect(response).to have_http_status(:success)
        end
         
        it "renders the #edit view" do
            ##get :edit, {id: my_post.id}
            get :edit, topic_id: my_topic.id, id: my_post.id
            expect(response).to render_template :edit
        end
         
        it "assigns post to be updated to @post" do
            ##get :edit, {id: my_post.id}
            get :edit, topic_id: my_topic.id, id: my_post.id
            post_instance = assigns(:post)
            
            expect(post_instance.id).to eq my_post.id
            expect(post_instance.title).to eq my_post.title
            expect(post_instance.body).to eq my_post.body
        end
    end
    
    describe "PUT update" do
        it "updates post with expected attributes" do
            new_title = RandomData.random_sentence
            new_body = RandomData.random_paragraph
            
            put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
            
            
            updated_post = assigns(:post)
            expect(updated_post.id).to eq(my_post.id)
            expect(updated_post.title).to eq(new_title)
            expect(updated_post.body).to eq(new_body)
        end
        
        it "redirects to the updated post" do
            new_title = RandomData.random_sentence
            new_body = RandomData.random_paragraph
            
            ##put :update, id: my_post.id, post: {title: new_title, body: new_body}
            ##expect(response).to redirect_to my_post
            
            put :update, topic_id: my_topic.id, id:my_post.id, post: {title: new_title, body: new_body}
            expect(response).to redirect_to [my_topic, my_post]
        end
    end
    
    describe "DELETE destroy" do
        it "deletes the post" do
            ##delete :destroy, {id: my_post.id}
            #we search the database for a post with an id equal to  my_post.id. 
            #This returns an Array. We assign the size of the array to count, 
            #and we expect count to equal zero. This test asserts that 
            #the database won't have a matching post after  destroy is called.
            delete :destroy, topic_id: my_topic.id, id: my_post.id
            count = Post.where({id: my_post.id}).size
            expect(count).to eq 0
        end
        
        ##it "redirects to posts index" do
            ##delete :destroy, {id: my_post.id}
            ##expect(response).to redirect_to posts_path
        ##end
        it "redirects to topic show" do
            delete :destroy, topic_id: my_topic.id, id: my_post.id
            expect(response).to redirect_to my_topic
        end
        ##we want to be redirected to the topics show view instead of the posts index view.
    end
   
end