require 'rails_helper'

RSpec.feature "Create Notes", type: :feature do
  let(:new_note_form) { NewNoteForm.new }
  let(:login_form) { LoginForm.new }
  let(:user) { FactoryGirl.create(:user) }

  background do
    login_form.visit_page.login_as(user)
  end

  scenario 'create new notes with valid data' do
    new_note_form.visit_page.fill_in_with(
      title: 'My first notes'
    ).submit

    expect(page).to have_content('Notes has been created')
    expect(Note.last.title).to eq('My first notes')
  end

  scenario 'cannot create new notes with invalid data' do
    new_note_form.visit_page.submit
    expect(page).to have_content("can't be blank")
  end

end
