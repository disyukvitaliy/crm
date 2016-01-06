require 'rails_helper'

RSpec.describe "projects/edit", type: :view do

  describe "rendering the project edit template" do
    it "displays the form" do
      assign(:project, Project.create(title: :title))

      render

      expect(rendered).to match /Edit Project/
    end
  end
end
