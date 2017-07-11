Given(/^I am a guest user$/) do
end

Given(/^there is a public note$/) do
  @note = FactoryGirl.create(:public_note, title: 'Just do it ')
end

When(/^I go to the note's page$/) do
  visit(note_path(@note.id))
end

Then(/^I must see note's content$/) do
  expect(page).to have_content('Just do it')
end
