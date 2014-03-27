require 'spec_helper'

feature 'User updates list' do

  background do
    @user = create(:user)
    sign_in_as(@user)
  end

  scenario 'and sees updated list' do
    click_button '+ New List'
    fill_in 'List Name', with: 'Vail'
    fill_in 'Departure Date', with: '2015-03-21'
    fill_in 'Departure Time', with: '2PM'
    click_button '+ Create List'
    click_link 'Edit'
    fill_in 'List Name', with: 'San Diego'
    click_button '+ Update List'
    expect(page).to have_content 'Updated the list!'
    expect(page).to have_content 'San Diego'
  end

end
