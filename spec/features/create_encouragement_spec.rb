require 'rails_helper'

RSpec.feature "Create Encouragement", type: :feature do
  let(:user) { FactoryGirl.create(:user) }
  let(:note) { FactoryGirl.create(:note, :public_note) }

  let(:login_form) { LoginForm.new }
  let(:note_page) { NotePage.new }
  let(:encouragement_form) { EncouragementForm.new }

  scenario 'athenticated user leaves encouragement for note' do
    login_form.visit_page.login_as(user)

    note_page.visit_page(note).encourage
    encouragement_form.leave_encouragement(text: 'You rock!').submit

    expect(page).to have_content("Encouragement left by #{user.email}")
    expect(page).to have_content("You rock!")
    expect(page).to have_css("#encouragement-quantity", text: '1')
  end
end
