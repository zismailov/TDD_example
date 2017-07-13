require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  include Rails.application.routes.url_helpers
  let(:note_id) { 1 }
  let(:email) { UserMailer.note_created('author@email.com', note_id).deliver_now }

  it 'sends note created email to author' do
    expect(email.to).to include('author@email.com')
  end

  it 'has correct subject' do
    expect(email.subject).to eq('Zaebisi with your new note!')
  end

  it 'has note link in body message' do
    expect(email.body.to_s).to include(note_url(note_id))
  end
end
