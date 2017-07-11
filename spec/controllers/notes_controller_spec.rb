require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe "#show" do
    let(:note) { FactoryGirl.create(:note, :public_note) }

    it "responds successfully" do
      get :show, params: { id: note.id }
      expect(response).to be_success
    end
  end

  describe "#create" do
    context "with valid attributes" do
      it "adds a note" do
        note_params = FactoryGirl.attributes_for(:note, :public_note)
        expect {
          post :create, params: { note: note_params }
        }.to change(Note, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "does not add a note" do
        note_params = FactoryGirl.attributes_for(:note, :public_note, :invalid)
        expect {
          post :create, params: { note: note_params }
        }.to_not change(Note, :count)
      end
    end
  end
end
