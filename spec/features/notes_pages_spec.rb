require 'rails_helper'

RSpec.feature "Notes Pages", type: :feature do
  scenario "notes public page" do
    note = FactoryGirl.create(:note, title: 'Just do it')
    visit("/notes/#{note.id}")

    expect(page).to have_content('Just do it')
  end

  scenario 'render markdown description' do
    note = FactoryGirl.create(:note, description: 'That is *cool*')
    visit("/notes/#{note.id}")

    expect(page).to have_css('em', text: 'cool')
  end
end
