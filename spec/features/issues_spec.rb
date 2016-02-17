require 'rails_helper'

RSpec.feature Issue, type: :feature do

  before do
    @user = sign_in
  end

  describe 'Check links on issue pages' do

    before do
      @project = create(:project, :with_issues, creator: @user)
      @issue = @project.issues.first
    end

    context 'index page' do

      before { visit project_issues_path @project }

      it { expect(page.status_code).to eql(200) if first('table.table tbody .subj a').click || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('edit') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('delete') || true; }

    end

    context 'show page' do

      before { visit issue_path @issue }

      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Edit') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Back') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Log time') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('0.0') || true; }

    end

    context 'edit page' do

      before { visit edit_issue_path @issue }

      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Show') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Back') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_button('Update') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Delete') || true; }

    end
  end

  describe 'CRUD operations' do

    before do
      @issue_priority = create(:activated_issue_priority)
      @issue_status = create(:activated_issue_status)
    end

    describe 'Creating a new issue' do

      before do
        @project = create(:project, creator: @user)
        visit new_project_issue_path @project
        @issue_count = Issue.count
      end

      context 'with invalid form inputs' do
        it 'do not create new issue and show alert message' do

          create_issue_with '', '', ''

          expect(page).to have_selector('.alert-danger', text: "Subj can't be blank")
          expect(page).to have_selector('.alert-danger', text: "Descr can't be blank")
          expect(page).to have_selector('.alert-danger', text: "Estimated time can't be blank")
          expect(Issue.count).to eq(@issue_count)

        end
      end

      context 'with wrong estimated time' do
        it 'do not create new issue and show alert message' do

          create_issue_with '', '', '2.321'
          expect(page).to have_selector('.alert-danger', text: "Estimated time has wrong format")

          create_issue_with '', '', '0.0'
          expect(page).to have_selector('.alert-danger', text: "Estimated time can not be a zero")

          expect(Issue.count).to eq(@issue_count)

        end
      end

      context 'with valid data' do
        it 'create new issue and show success message' do

          create_issue_with 'test', 'test', '2:30', @issue_priority.title, @issue_status.title
          expect(page).not_to have_selector('.alert-danger')
          expect(page).to have_selector('.alert-success', text: 'Has successfully created')
          expect(Issue.count).to eq(@issue_count + 1)

        end
      end
    end

    describe 'Updating an issue' do

      before do
        @project = create(:project, :with_issues, creator: @user)
        visit edit_issue_path @project.issues.first
      end

      context 'with invalid form inputs' do
        it 'do not update issue and show alert message' do
          update_issue_with '', '', ''
          expect(page).to have_selector('.alert-danger', text: "Subj can't be blank")
        end
      end

      context 'with valid form inputs' do
        it 'update project and show success message' do
          update_issue_with 'test', 'test', '2.2', @issue_priority.title, @issue_status.title
          expect(page).to have_selector('.alert-success', text: 'Has successfully updated')
        end
      end
    end

    describe 'Deleting an issue' do

      before do
        @project = create(:project, :with_issues, creator: @user)
        @issue = @project.issues.first
        @issue_count = Issue.count
      end

      context 'delete it via edit page' do
        it 'successfully delete issue' do

          visit edit_issue_path @issue
          find('.form-horizontal').click_link('Delete')
          expect(page.status_code).to eql(200)
          expect(Issue.count).to eq(@issue_count - 1)

        end
      end

      context 'delete it via index page' do
        it 'successfully delete issue' do

          visit project_issues_path @project
          first('table.table tbody .actions').click_link('delete')
          expect(page.status_code).to eql(200)
          expect(Issue.count).to eq(@issue_count - 1)

        end
      end
    end
  end

  describe 'Access to issue' do

    context 'created by another user' do
      it 'show me 401 page' do

        project = create(:project, :with_issues)
        visit issue_path project.issues.first
        expect(page.status_code).to eql(401)

      end
    end

    context 'created by me' do
      it 'show me issue page' do

        project = create(:project, :with_issues, creator: @user)
        visit issue_path project.issues.first
        expect(page.status_code).to eql(200)

      end
    end

    context 'created by another user and then project is added to my accessed_projects association' do
      it 'show me issue page' do

        project = create(:project, :with_issues)
        project.accessed_users << @user
        visit issue_path project.issues.first
        expect(page.status_code).to eql(200)

      end
    end
  end
end
