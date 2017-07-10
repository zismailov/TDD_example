require 'rails_helper'

RSpec.feature "Home Pages", type: :feature do
  scenario 'welcome message' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end
