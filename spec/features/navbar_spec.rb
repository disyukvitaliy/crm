require 'rails_helper'

RSpec.feature 'Navbar', type: :feature do

  before { sign_in }

  describe 'Navbar panel' do

    context 'check all links' do

      before { visit root_path }

      it { expect(page.status_code).to eql(200) if click_link('Settings') || true; }
      it { expect(page.status_code).to eql(200) if click_link('Issue statuses') || true; }
      it { expect(page.status_code).to eql(200) if click_link('Enumerators') || true; }
      it { expect(page.status_code).to eql(200) if click_link('Activities') || true; }
      it { expect(page.status_code).to eql(200) if click_link('Issue priorities') || true; }
      it { expect(page.status_code).to eql(200) if click_link('Users') || true; }
      it { expect(page.status_code).to eql(200) if click_link('Roles') || true; }
      it { expect(page.status_code).to eql(200) if click_link('Permissions') || true; }
      it { expect(page.status_code).to eql(200) if click_link('Sign out') || true; }
      it { expect(page.status_code).to eql(200) if find('.navbar').click_link('Edit') || true; }

    end
  end
end
