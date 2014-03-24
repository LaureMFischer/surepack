require 'spec_helper'

feature 'User visits home page' do

  background do
    @user = create(:user)
    @list = create(:list, user: @user)
    sign_in_as(@user)
  end

  scenario 'and sees all packing lists' do
    expect(page).to have_content @list.name
    expect(page).to have_button '+ New List'
  end
end
