require 'rails_helper'

RSpec.feature "Notes API", type: :request do
  it 'sends public notes' do
    public_note = FactoryGirl.create(:note, :public_note, title: 'My note')
    private_note = FactoryGirl.create(:note, :private_note)

    get '/api/notes',  headers: { "Content-Type": "application/vnd.api+json" }

    expect(response).to have_http_status "200"
    json = JSON.parse(response.body)

    expect(json['data'].count).to eq(1)
    expect(json['data'][0]['type']).to eq('notes')
    expect(json['data'][0]['attributes']['title']).to eq('My note')
  end
end
