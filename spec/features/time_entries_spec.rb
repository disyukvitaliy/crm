require 'rails_helper'

RSpec.feature TimeEntry, type: :feature do

  before do
    @user = sign_in
  end

  describe 'Check links on time entry pages' do

    before do
      @issue = create(:issue, :with_time_entries, user: @user)
      @issue.project.accessed_users << @user
      @time_entry = @issue.time_entries.first
      @time_entry.update(user: @user)
    end

    context 'index page' do

      before { visit issue_time_entries_path @issue }

      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('edit') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('delete') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('New') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Back') || true; }

    end

    context 'edit page' do

      before { visit edit_time_entry_path @time_entry }

      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Back') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_button('Update') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Delete') || true; }

    end
  end

  describe 'CRUD operations' do

    before do
      @activity = create(:activated_activity)
    end

    describe 'Creating a new time entry' do

      before do
        @issue = create(:issue)
        visit new_issue_time_entry_path @issue
        @time_entry_count = TimeEntry.count
      end

      context 'with invalid form inputs' do
        it 'do not create new time entry and show alert message' do

          create_time_entry_with '', ''

          expect(page).to have_selector('.alert-danger', text: "Date can't be blank")
          expect(page).to have_selector('.alert-danger', text: "Amount can't be blank")
          expect(TimeEntry.count).to eq(@time_entry_count)

        end
      end

      context 'with wrong amount' do
        it 'do not create new time entry and show alert message' do

          create_time_entry_with '', '2.321'
          expect(page).to have_selector('.alert-danger', text: "Amount has wrong format")

          create_time_entry_with '', '0.0'
          expect(page).to have_selector('.alert-danger', text: "Amount can not be a zero")

          expect(TimeEntry.count).to eq(@time_entry_count)

        end
      end

      context 'with create_time_entry_with data' do
        it 'create new time entry and show success message' do

          create_time_entry_with DateTime.now, '2:30', @activity.title
          expect(page).not_to have_selector('.alert-danger')
          expect(page).to have_selector('.alert-success', text: 'Has successfully created')
          expect(TimeEntry.count).to eq(@time_entry_count + 1)

        end
      end
    end

    describe 'Updating an time entry' do

      before do
        @issue = create(:issue, :with_time_entries)
        @time_entry = @issue.time_entries.first
        @time_entry.update(user: @user)
        visit edit_time_entry_path @time_entry
      end

      context 'with invalid form inputs' do
        it 'do not update time entry and show alert message' do
          update_time_entry_with '', ''
          expect(page).to have_selector('.alert-danger', text: "Date can't be blank")
        end
      end

      context 'with valid form inputs' do
        it 'update time entry and show success message' do
          update_time_entry_with DateTime.now, '2.2', @activity.title
          expect(page).to have_selector('.alert-success', text: 'Has successfully updated')
        end
      end
    end

    describe 'Deleting a time entry' do

      before do
        @issue = create(:issue, :with_time_entries)
        @time_entry = @issue.time_entries.first
        @time_entry.update(user: @user)
        @time_entry_count = TimeEntry.count
      end

      context 'delete it via edit page' do
        it 'successfully delete time entry' do

          visit edit_time_entry_path @time_entry
          find('.form-horizontal').click_link('Delete')
          expect(page.status_code).to eql(200)
          expect(TimeEntry.count).to eq(@time_entry_count - 1)

        end
      end

      context 'delete it via index page' do
        it 'successfully delete time entry' do

          visit issue_time_entries_path @issue
          first('table.table tbody .actions').click_link('delete')
          expect(page.status_code).to eql(200)
          expect(TimeEntry.count).to eq(@time_entry_count - 1)

        end
      end
    end
  end
end
