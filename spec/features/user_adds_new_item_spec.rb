require 'spec_helper'

feature 'User adds new item' do

  background do
    @user = create(:user)
    sign_in_as(@user)
    click_link '+ New List'
    fill_in 'List Name', with: 'Vail'
    fill_in 'Departure Date', with: '2015-03-21'
    fill_in 'Departure Time', with: '2PM'
    click_button '+ Create List'
  end

  scenario 'and it gets added to the current list' do
    click_link '+ Add New Item'
    fill_in 'Item Name', with: 'Boots'
    fill_in 'Category', with: 'Shoes'
    click_button '+ Add'
    expect(page).to have_button 'Clear'
    expect(page).to have_content 'Boots'
  end
end
