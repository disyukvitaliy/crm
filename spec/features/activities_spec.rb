require 'rails_helper'

RSpec.feature Activity, type: :feature do

  before { sign_in }

  describe 'Check links on activity pages' do

    context 'index page' do

      before { visit activities_path }

      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('New') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .element_order').click_link('up') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .element_order').click_link('down') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('edit') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('delete') || true; }
      it { expect(page.status_code).to eql(200) if first('table.table tbody .actions').click_link('default') || true; }

    end

    context 'edit page' do

      before { visit edit_activity_path Activity.first }

      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Back') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_button('Update') || true; }
      it { expect(page.status_code).to eql(200) if find('#main-block-right').click_link('Delete') || true; }

    end
  end

  describe 'Creating a new activity' do

    before do
      visit new_activity_path
      @activity_count = Activity.count
    end

    context 'with invalid form inputs' do
      it 'do not create new activity and show alert message' do

        create_activity_with ''

        expect(page.status_code).to eql(200)
        expect(page).to have_selector('.alert-danger', text: "Title can't be blank")
        expect(Activity.count).to eq(@activity_count)

      end
    end

    context 'with valid form inputs' do
      it 'create new activity and show success message' do

        create_valid_activity

        expect(page.status_code).to eql(200)
        expect(page).to have_selector('.alert-success', text: 'Has successfully created')
        expect(Activity.count).to eq(@activity_count + 1)

      end
    end
  end

  describe 'Updating an activity' do

    before do
      visit edit_activity_path Activity.first
    end

    context 'with invalid form inputs' do
      it 'do not update activity and show alert message' do

        update_activity_with ''

        expect(page.status_code).to eql(200)
        expect(page).to have_selector('.alert-danger', text: "Title can't be blank")

      end
    end

    context 'with valid form inputs' do
      it 'update activity and show success message' do

        update_activity_with 'Some activity'

        expect(page.status_code).to eql(200)
        expect(page).to have_selector('.alert-success', text: 'Has successfully updated')

      end
    end
  end

  describe 'Deleting an activity' do

    context 'delete via Delete button' do
      it 'successfully delete activity' do

        visit new_activity_path
        create_valid_activity

        @activity_count = Activity.count

        find('.form-horizontal').click_link('Delete')

        expect(page.status_code).to eql(200)
        expect(Activity.count).to eq(@activity_count - 1)
      end
    end
  end
end
