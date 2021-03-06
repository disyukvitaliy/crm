require 'rails_helper'

RSpec.feature Project, type: :feature do

  before { @user = sign_in }

  describe 'Check links on project pages' do

    context 'index page' do

      before { visit projects_path }

      it { expect(page.status_code).to eql(200) if click_link('Projects') || true; }
      it { expect(page.status_code).to eql(200) if click_link('New project') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .title a').click || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('edit') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('delete') || true; }

    end

    context 'show page' do

      before { visit project_path Project.first }

      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Edit') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Back') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Issues') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('New issue') || true; }

    end
  end

  describe 'Check left menu links' do

    context 'with no project selected' do

      before { visit projects_path }

      it { expect(page).not_to have_selector('#main-block-left', text: 'Issues') }
      it { expect(page).not_to have_selector('#main-block-left', text: 'New issue') }
      it { expect(page).not_to have_selector('#main-block-left', text: 'News') }
      it { expect(page).not_to have_selector('#main-block-left', text: 'Wiki') }
    end

    context 'with some project selected' do

      before { visit project_path Project.first }

      it { expect(page.status_code).to eql(200) if find('#main-block-left').click_link('Issues') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-left').click_link('New issue') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-left').click_link('News') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-left').click_link('Wiki') || true; }
    end
  end

  describe 'Creating a new project' do

    before do
      visit new_project_path
      @project_count = Project.count
    end

    context 'with invalid form inputs' do
      it 'do not create new project and show alert message' do

        create_project_with ''

        expect(page.status_code).to eql(200)
        expect(page).to have_selector('.alert-danger', text: "Title can't be blank")
        expect(Project.count).to eq(@project_count)

      end
    end

    context 'with valid form inputs' do
      it 'create new project and show success message' do

        create_valid_project

        expect(page.status_code).to eql(200)
        expect(page).to have_selector('.alert-success', text: 'Has successfully created')
        expect(Project.count).to eq(@project_count + 1)

      end
    end
  end

  describe 'Updating a project' do

    before do
      visit edit_project_path Project.first
    end

    context 'with invalid form inputs' do
      it 'do not update project and show alert message' do

        update_project_with ''

        expect(page.status_code).to eql(200)
        expect(page).to have_selector('.alert-danger', text: "Title can't be blank")

      end
    end

    context 'with valid form inputs' do
      it 'update project and show success message' do

        update_project_with 'Some project'

        expect(page.status_code).to eql(200)
        expect(page).to have_selector('.alert-success', text: 'Has successfully updated')

      end
    end
  end

  describe 'Deleting a project' do

    context 'create new project without issues' do

      before do
        @project = create(:project, creator: @user)
        @project_count = Project.count
      end

      context 'delete it via edit page' do
        it 'successfully delete project' do

          visit edit_project_path @project
          find('.form-horizontal').click_link('Delete')
          expect(page.status_code).to eql(200)
          expect(Project.count).to eq(@project_count - 1)

        end
      end

      context 'delete it via index page' do
        it 'successfully delete project' do

          visit projects_path

          within '#new_projects_grid' do
            fill_in :projects_grid_title, with: @project.title
            click_button 'Search'
          end

          first('table.table tbody .actions').click_link('delete')
          expect(page.status_code).to eql(200)
          expect(Project.count).to eq(@project_count - 1)

        end
      end
    end

    context 'create new project with issues' do

      before do
        @project = create(:project, :with_issues, creator: @user)
        @project_count = Project.count
      end

      context 'delete it via edit page' do
        it 'do not delete project and show alert' do

          visit edit_project_path @project
          find('.form-horizontal').click_link('Delete')
          expect(page.status_code).to eql(200)
          expect(page).to have_selector('.alert-danger', text: 'Cannot delete record because dependent issues exist')
          expect(Project.count).to eq(@project_count)

        end
      end

      context 'delete it via index page' do
        it 'don not delete project and show alert' do

          visit projects_path

          within '#new_projects_grid' do
            fill_in :projects_grid_title, with: @project.title
            click_button 'Search'
          end

          first('table.table tbody .actions').click_link('delete')
          expect(page.status_code).to eql(200)
          expect(Project.count).to eq(@project_count)

        end
      end
    end
  end

  describe 'Access to project' do

    context 'created by another user' do
      it 'show me 401 page' do

        project = create(:project)
        visit project_path project
        expect(page.status_code).to eql(401)

      end
    end

    context 'created by me' do
      it 'show me project page' do

        project = create(:project, creator: @user)
        visit project_path project
        expect(page.status_code).to eql(200)

      end
    end

    context 'created by another user and then added to my accessed_projects association' do
      it 'show me project page' do

        project = create(:project)
        project.accessed_users << @user
        visit project_path project
        expect(page.status_code).to eql(200)

      end
    end
  end
end
