require 'rails_helper'

RSpec.feature "Create Notes", type: :feature do
  scenario 'create new notes with valid data' do
    visit('/')
    click_on('New Notes')

    fill_in('Title', with: 'My first notes')
    fill_in('Description', with: 'Excellent create my notes')
    select('Public', from: 'Privacy')
    check('Featured notes')
    attach_file('Cover image', "#{Rails.root}/spec/fixtures/cover_image.png")
    click_on('Create Notes')

    expect(page).to have_content('Notes has been created')
    expect(Note.last.title).to eq('My first notes')
  end

  scenario 'cannot create new notes with invalid data' do
    visit('/')
    click_on('New Notes')

    click_on('Create Notes')

    expect(page).to have_content("can't be blank")
  end

end
