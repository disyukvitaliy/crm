require 'rails_helper'

RSpec.describe "issues/new", type: :view do
  before(:each) do
    assign(:issue, Issue.new(
      :subj => "MyText",
      :descr => "MyText"
    ))
  end

  it "renders new issue form" do
    render

    assert_select "form[action=?][method=?]", issues_path, "post" do

      assert_select "textarea#issue_subj[name=?]", "issue[subj]"

      assert_select "textarea#issue_descr[name=?]", "issue[descr]"
    end
  end
end
