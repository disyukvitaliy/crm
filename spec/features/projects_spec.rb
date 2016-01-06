require 'rails_helper'

RSpec.feature Project, type: :feature do

  describe 'new project creation' do

    before :each do
      visit new_project_path
    end

    context 'with valid form inputs' do
      it 'create new project and redirect to index' do

        within("#new_project") do
          fill_in :title, with: :title
          click_button 'Create'
        end

        expect(page).to have_text('Projects')
        expect(page).to have_selector('h3')
        expect(Project.count).to eq(1)

      end
    end

    context 'with invalid form inputs' do
      it 'do not create new project and render new template' do

        within("#new_project") do
          fill_in :title, with: ''
          click_button 'Create'
        end

        expect(page).to have_text('New project')
        expect(page).to have_button('Create')
        expect(Project.count).to eq(0)
      end
    end

  end
end
