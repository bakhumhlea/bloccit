require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
    
    let(:name) { RandomData.random_sentence }
    let(:description) { RandomData.random_paragraph }
    
    let(:title) { RandomData.random_sentence }
    let(:body) { RandomData.random_paragraph }
    let(:price) { RandomData.random_price }
    
    let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
    
    let(:topic) { Topic.create!(name: name, description: description) }
    
    let(:sponsored_post) { topic.sponsored_posts.create!(title: title, body: body, price: price, user: user) }
    
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
    
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:topic) }
    it { is_expected.to validate_presence_of(:user) }

    describe "attributes" do
        it "has title, body, price and user attributes" do
            expect(sponsored_post).to have_attributes(title: title, body: body, price: price, user: user)
        end
    end
end
