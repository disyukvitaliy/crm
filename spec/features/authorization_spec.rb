require 'rails_helper'

RSpec.feature 'Authorization', type: :feature do

  let(:wrong) { {user_email: 'wrong@user.com', user_password: 'wrong_password'} }
  let(:new) { {user_email: 'test@test.com', user_password: 'testtest'} }

  describe 'Checking links on authorization pages' do

    context 'sign in page' do

      before { visit new_user_session_path }

      it { expect(page.status_code).to eql(200) if find('.navbar').click_link('Log in') || true; }
      it { expect(page.status_code).to eql(200) if find('.navbar').click_link('Sign up') || true; }
      it { expect(page.status_code).to eql(200) if find('.well').click_link('Sign up') || true; }
      it { expect(page.status_code).to eql(200) if find('.well').click_link('Forgot your password?') || true; }
    end

    context 'sign up page' do

      before { visit new_user_registration_path }

      it { expect(page.status_code).to eql(200) if find('.well').click_link('Log in') || true; }
    end

    context 'Password recovery page' do

      before { visit new_user_password_path }

      it { expect(page.status_code).to eql(200) if find('.well').click_link('Log in') || true; }
      it { expect(page.status_code).to eql(200) if find('.well').click_link('Sign up') || true; }
    end
  end

  describe 'Try of not authorized access' do

    let(:alert_message) { 'You need to sign in or sign up before continuing.' }

    context 'Visit root path' do
      it 'redirect us to sign in page with no alert' do

        visit root_path

        expect(page).not_to have_selector('.alert-danger', text: alert_message)
        expect(page.current_path).to eq new_user_session_path
      end
    end

    context 'Visit not root path' do
      it 'redirect us to sign in page with alert' do

        visit projects_path

        expect(page).to have_selector('.alert-danger', text: alert_message)
        expect(page.current_path).to eq new_user_session_path
      end
    end
  end

  describe 'Sign up process' do

    before(:each) { visit new_user_registration_path }

    context 'visiting sign up page' do
      it 'consist of next elements' do

        expect(page).to have_selector('h2', text: 'Sign up')
        expect(page).to have_selector('a', text: 'Log in')
        expect(page).not_to have_select('.panel-ava')
        expect(page).not_to have_text('.breadcrumb')

      end
    end

    context 'With empty data' do
      it 'show warning messages' do

        sign_up_with '', '', ''

        expect(page).to have_selector('.alert-danger', text: "Email can't be blank")
        expect(page).to have_selector('.alert-danger', text: "Password can't be blank")

      end
    end

    context 'with not matching passwords' do
      it 'show warning messages' do

        sign_up_with new[:user_email], new[:user_password], wrong[:user_password]

        expect(page).to have_selector('.alert-danger', text: "Password confirmation doesn't match Password")

      end
    end

    context 'with valid data' do
      it 'sign up us and redirect to sign in page with notice' do

        sign_up_with new[:user_email], new[:user_password], new[:user_password]

        expect(page).to have_selector('.alert-info', text: 'You have signed up successfully. However, we could not sign you in because your account is not yet activated.')
        expect(page).to have_selector('h2', text: 'Log in')
        expect(page).not_to have_selector('.panel-ava')
        expect(page).not_to have_text('.breadcrumb')

      end
    end
  end

  describe 'Sign in process' do

    before(:each) { visit new_user_session_path }

    context 'visiting sign in page' do
      it 'consist of next elements' do

        expect(page).to have_selector('h2', text: 'Log in')
        expect(page).to have_selector('a', text: 'Sign up')
        expect(page).to have_selector('a', text: 'Forgot your password?')
        expect(page).not_to have_select('.panel-ava')
        expect(page).not_to have_text('.breadcrumb')

      end
    end

    context 'With invalid form inputs' do
      it 'show warning message' do

        sign_in_with wrong[:user_email], wrong[:user_password]

        expect(page).to have_text('Invalid email or password')
        expect(page).to have_selector('.alert-danger')

      end
    end

    context 'with valid form inputs' do
      it 'authorise us and redirect to root path' do

        sign_in

        expect(page).not_to have_selector('h2', text: 'Log in')
        expect(page).not_to have_selector('.alert-danger')
        expect(page).to have_selector('.panel-ava')
        expect(page).to have_selector('.breadcrumb')

      end
    end
  end

  describe 'Password recovery process' do

    context 'With wrong email' do
      it 'show warning message' do

        visit new_user_password_path

        restore_password_for wrong[:user_email]

        expect(page).to have_selector('.alert-danger', text: 'Email not found')
      end
    end

    context 'With valid email' do
      it 'send me email with recovery link' do

        visit new_user_registration_path

        sign_up_with new[:user_email], new[:user_password], new[:user_password]

        visit new_user_password_path

        restore_password_for new[:user_email]

        expect(Devise.mailer.deliveries.first.subject).to eq 'Reset password instructions'
        expect(Devise.mailer.deliveries.first.body).to include 'Change my password'
        expect(Devise.mailer.deliveries.count).to eq 1

      end
    end
  end

  describe 'Sign out process' do

    before { sign_in }
    context 'after sign in' do
      it { expect(page.current_path).to eq(new_user_session_path) if click_link('Sign out') || true }
    end

  end
end
