require 'rails_helper'

RSpec.describe Advertisement, type: :model do
    let(:ads) { Advertisement.create!(title: "Ads Title", body: "Ads Content", price: 5500) }
  
    describe "attributes" do
        it "has title, body and price  attributes" do
            expect(ads).to have_attributes(title: "Ads Title", body: "Ads Content", price: 5500)
        end
    end
end
