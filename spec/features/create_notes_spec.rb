require 'rails_helper'

RSpec.feature "Create Notes", type: :feature do
  let(:new_note_form) { NewNoteForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { FactoryGirl.create(:user) }

  background do
    login_form.visit_page.login_as(user)
  end

  scenario 'create new notes with valid data', :vcr do
    new_note_form.visit_page.fill_in_with(
      title: 'My first notes',
      cover_image: 'cover_image.png'
    ).submit

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(ActionMailer::Base.deliveries.last.to).to include(user.email)

    expect(Note.last.cover_image_identifier).to eq('cover_image.png') #cover_image_identifier is 'carrierwave' method
    expect(page).to have_content('Notes has been created.')
    expect(Note.last.title).to eq('My first notes')
    expect(page).to have_content('We tweeted for you! https://twitter.com')
  end

  scenario 'cannot create new notes with invalid data' do
    new_note_form.visit_page.submit
    expect(page).to have_content("can't be blank")
  end

end
