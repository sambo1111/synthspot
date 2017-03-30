require 'rails_helper'

RSpec.describe "reviews/new", type: :view do
  before(:each) do
    assign(:review, Review.new(
      :topic => "MyString",
      :body => "MyText",
      :score => 1,
      :user_id => 1,
      :instrument_id => 1
    ))
  end

  it "renders new review form" do
    render

    assert_select "form[action=?][method=?]", reviews_path, "post" do

      assert_select "input#review_topic[name=?]", "review[topic]"

      assert_select "textarea#review_body[name=?]", "review[body]"

      assert_select "input#review_score[name=?]", "review[score]"

      assert_select "input#review_user_id[name=?]", "review[user_id]"

      assert_select "input#review_instrument_id[name=?]", "review[instrument_id]"
    end
  end
end
