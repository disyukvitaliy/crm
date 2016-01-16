require 'rails_helper'

RSpec.describe "issues/show", type: :view do
  before(:each) do
    @issue = assign(:issue, Issue.create!(
      :subj => "MyText",
      :descr => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
