require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end

    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

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

  describe "#update" do
    let(:note) { FactoryGirl.create(:note, :public_note) }

    context "valid data" do
      let(:note_params) { FactoryGirl.attributes_for(:note, :public_note, title: "New Note") }

      it "redirects to note#show" do
        patch :update, params: {id: note, note: note_params }
        expect(response).to redirect_to(note)
      end

      it "updates a note" do
        patch :update, params: {id: note, note: note_params }
        expect(note.reload.title).to eq "New Note"
      end
    end

    context "invalid data" do
      let(:note_params) { FactoryGirl.attributes_for(:note, :public_note, :invalid, description: "New") }

      it "renders :edit template" do
        patch :update, params: {id: note, note: note_params }
        expect(response).not_to be_redirect
      end

      it "doesn't update a note" do
        patch :update, params: {id: note, note: note_params }
        expect(note.reload.description).not_to eq "New"
      end
    end

  end

  describe "#destroy" do
    let(:note) { FactoryGirl.create(:note, :public_note) }

    it "redirects to note#index" do
      delete :destroy, params: { id: note.id }
      expect(response).to redirect_to(note_path)
    end

    it "deletes a note" do
      delete :destroy, params: { id: note.id }
      expect(Note.exists?(note.id)).to be_falsy
    end
  end

end
