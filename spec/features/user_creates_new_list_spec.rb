require 'spec_helper'

feature 'User creates new list' do

  background do
    @user = create(:user)
    sign_in_as(@user)
  end

  scenario 'and sees options to add to list' do
    click_button '+ New List'
    fill_in 'List Name', with: 'Vail'
    fill_in 'Departure Date', with: '2015-03-21'
    fill_in 'Departure Time', with: '2PM'
    click_button '+ Create List'
    expect(page).to have_content 'Vail'
    expect(page).to have_button '+ New Item'
    expect(page).to have_button '+ Add from Existing'
    expect(page).to have_button 'Reset'
  end

  scenario 'unsuccessfully because the list name is a duplicate' do
    click_button '+ New List'
    fill_in 'List Name', with: 'Vail'
    fill_in 'Departure Date', with: '2015-03-21'
    fill_in 'Departure Time', with: '2PM'
    click_button '+ Create List'
    visit root_path
    click_button '+ New List'
    fill_in 'List Name', with: 'Vail'
    fill_in 'Departure Date', with: '2015-03-21'
    fill_in 'Departure Time', with: '2PM'
    click_button '+ Create List'
    expect(page).to have_content "You've already created a list with this name."
  end
end
