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

  scenario 'from scratch' do
    click_button '+ Add New Item'
    fill_in 'Item Name', with: 'Boots'
    select('Shoes', :from => 'Category')
    click_button '+ Add'
    expect(page).to have_button 'Clear'
    expect(page).to have_button '+ Add New Item'
    expect(page).to have_button '+ Add Item from Existing'
    expect(page).to have_content 'Boots'
    expect(page).to have_content "Your item has been created!"
  end

  scenario 'unsuccessfully because the item name is a duplicate' do
    click_button '+ Add New Item'
    fill_in 'Item Name', with: 'Boots'
    select('Shoes', :from => 'Category')
    click_button '+ Add'
    click_button '+ Add New Item'
    fill_in 'Item Name', with: 'Boots'
    select('Shoes', :from => 'Category')
    click_button '+ Add'
    expect(page).to have_content "You've already created this item!"
  end

end
