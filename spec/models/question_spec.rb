require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title:"New Question", body: "question content" ,resolved: false) }
  
  describe "attribute" do 
      it "has title, body and resolved attributes" do
          expect(question).to have_attributes(title:"New Question", body: "question content" ,resolved: false)
      end
  end
end
