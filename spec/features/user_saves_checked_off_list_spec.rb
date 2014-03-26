require 'spec_helper'

feature 'User saves checked off list' do

  background do
    @user = create(:user)
    sign_in_as(@user)
  end

  scenario 'successfully' do
    click_link '+ New List'
    fill_in 'List Name', with: 'Vail'
    fill_in 'Departure Date', with: '2015-03-21'
    fill_in 'Departure Time', with: '2PM'
    click_button '+ Create List'
    click_link '+ Add New Item'
    fill_in 'Item Name', with: 'Boots'
    fill_in 'Category', with: 'Shoes'
    click_button '+ Add'
    check 'items_checkbox_'
    click_button 'Save'
    expect(page).to have_content 'Your list has been saved!'
  end
end
