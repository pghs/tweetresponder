require 'spec_helper'

describe "questions/new" do
  before(:each) do
    assign(:question, stub_model(Question,
      :q_id => 1,
      :question => "MyText",
      :answer => "MyString",
      :tweet => "MyText",
      :url => "MyString",
      :short_url => "MyString"
    ).as_new_record)
  end

  it "renders new question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => questions_path, :method => "post" do
      assert_select "input#question_q_id", :name => "question[q_id]"
      assert_select "textarea#question_question", :name => "question[question]"
      assert_select "input#question_answer", :name => "question[answer]"
      assert_select "textarea#question_tweet", :name => "question[tweet]"
      assert_select "input#question_url", :name => "question[url]"
      assert_select "input#question_short_url", :name => "question[short_url]"
    end
  end
end
