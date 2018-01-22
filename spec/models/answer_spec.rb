require 'rails_helper'

RSpec.describe Answer, type: :model do
    let(:question) { Question.create!(title: "New Question", body: "question content" ,resolved: false) }
    let(:answer) { Answer.create!(body: "Answer body", question: question) }
    
    describe "attribute" do
        it "has body attribute" do
           expect(answer).to have_attributes(body:'Answer body') 
        end
    end
end
