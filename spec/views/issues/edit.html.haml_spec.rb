require 'rails_helper'

RSpec.describe "issues/edit", type: :view do
  before(:each) do
    @issue = assign(:issue, Issue.create!(
      :subj => "MyText",
      :descr => "MyText"
    ))
  end

  it "renders the edit issue form" do
    render

    assert_select "form[action=?][method=?]", issue_path(@issue), "post" do

      assert_select "textarea#issue_subj[name=?]", "issue[subj]"

      assert_select "textarea#issue_descr[name=?]", "issue[descr]"
    end
  end
end
