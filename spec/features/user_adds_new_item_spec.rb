require 'spec_helper'

feature 'User adds new item' do

  background do
    @user = create(:user)
    sign_in_as(@user)
    click_button '+ New List'
    fill_in 'List Name', with: 'Vail'
    fill_in 'Departure Date', with: '2015-03-21'
    fill_in 'Departure Time', with: '2PM'
    click_button '+ Create List'
  end

  scenario 'from scratch' do
    click_button '+ New Item'
    fill_in 'Item Name', with: 'Boots'
    select('Shoes', :from => 'Category')
    click_button '+ Add'
    expect(page).to have_button 'Clear'
    expect(page).to have_button '+ New Item'
    expect(page).to have_button '+ Add Item'
    expect(page).to have_content 'Boots'
    expect(page).to have_content "Your item has been created!"
  end

end
