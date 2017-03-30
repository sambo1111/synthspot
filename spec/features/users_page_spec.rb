require 'rails_helper'

describe "User" do

  describe "who has signed in" do
    let!(:user) { FactoryGirl.create(:user, username:"eetvart", admin:false) }

    before :each do
      visit signin_path
      fill_in('username', with:'eetvart')
      fill_in('password', with:'salainen')
      click_button('Log in')
    end

    it "index page lists all users" do

      FactoryGirl.create(:user, username:"jyrgen", admin:false)
      visit users_path

      expect(page).to have_content 'jyrgen'
    end

    it "can sign out properly" do
      click_link "Sign Out"
      expect(page).to have_content 'Sign In'
      expect(page).not_to have_content 'Sign Out'
    end

    it "can add instruments to his setup" do
      FactoryGirl.create(:instrument, name:"DR-550")
      click_link "My User"
      click_link "Add instrument to studio"

      select("DR-550", from:"user_instrument_instrument_id")
      click_button('Create User instrument')
      expect(page).to have_content 'eetvart'
      expect(page).to have_content 'DR-550'
    end

    it "can create suggestions" do
      click_link "Leave a suggestion"
      fill_in('Topic', with:'add this')
      fill_in('Info', with:'yabbadabba')
      click_button('Create Suggestion')

      expect(page).to have_content('Suggestion was successfully created.')
      expect(Suggestion.count).to eq(1)
    end

  end

  describe "who has not signed up" do

    it "is added to the system when signing up" do

      visit signup_path
      fill_in('Username', with:'bestuser')
      fill_in('Password', with:'salis')
      fill_in('Password confirmation', with:'salis')
      click_button("Create User")

      expect(User.count).to eq(1)
      expect(page).to have_content 'User was successfully created.'
    end

  end
end