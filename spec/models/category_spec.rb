require 'spec_helper'

describe Category do
  
  it "has a valid factory" do
    build(:category).should be_valid
  end
  
  it "is has id equal to bd_id" do
    category = create(:category)
    category.id.should eq(category.bd_id)
  end
  
end
