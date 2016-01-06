require 'rails_helper'

RSpec.describe "projects/new", type: :view do

  describe "rendering the project new template" do
    it "displays the form" do
      assign(:project, Project.new(title: :title))

      render
      # render template: "projects/new.html.haml"

      expect(rendered).to match /New Project/
    end
  end
end
