require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  describe "#index" do
    context "as an authenticated user" do
    end

    context "as a guest" do
      it "responds successfully" do
        get :index
        expect(response).to be_success
      end

      it "returns a 200 response" do
        get :index
        expect(response).to have_http_status "200"
      end
    end
  end

  describe "#show" do
    context "as an authorized user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:note) { FactoryGirl.create(:note, :public_note, user: user) }

      before do
        sign_in user
      end

      it "responds successfully" do
        get :show, params: { id: note.id }
        expect(response).to be_success
      end
    end
  end

  describe "#create" do
    context "as an authenticated user" do
      let(:user) { FactoryGirl.create(:user) }

      before do
        sign_in user
      end

      context "with valid attributes" do
        it "adds a note" do
          note_params = FactoryGirl.attributes_for(:note, :public_note)
          expect {
            post :create, params: { note: note_params }
          }.to change(user.notes, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not add a note" do
          note_params = FactoryGirl.attributes_for(:note, :invalid)
          expect {
            post :create, params: { note: note_params }
          }.to_not change(user.notes, :count)
        end
      end

    end

    context "as a guest" do
      it "returns a 302 response" do
        note_params = FactoryGirl.attributes_for(:note)
        post :create, params: { note: note_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        note_params = FactoryGirl.attributes_for(:note)
        post :create, params: { note: note_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:note) { FactoryGirl.create(:note, :public_note, user: user) }

      before do
        sign_in user
      end

      it "updates a note" do
        note_params = FactoryGirl.attributes_for(:note, title: "New Note Name")
        patch :update, params: { id: note.id, note: note_params }
        expect(note.reload.title).to eq "New Note Name"
      end
    end

    context "as an unauthorized user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user) }
      let(:note) { FactoryGirl.create(:note, user: other_user, title: "Same Old Name") }

      before do
        sign_in user
      end

      it "does not update the note" do
        note_params = FactoryGirl.attributes_for(:note, title: "New Name")
        patch :update, params: { id: note.id, note: note_params }
        expect(note.reload.title).to eq "Same Old Name"
      end

      it "redirects to the note" do
        note_params = FactoryGirl.attributes_for(:note)
        patch :update, params: { id: note.id, note: note_params }
        expect(response).to redirect_to(notes_path)
      end
    end

    context "as a guest" do
      let(:note) { FactoryGirl.create(:note) }

      it "returns a 302 response" do
        note_params = FactoryGirl.attributes_for(:note)
        patch :update, params: { id: note.id, note: note_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        note_params = FactoryGirl.attributes_for(:note)
        patch :update, params: { id: note.id, note: note_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:note) { FactoryGirl.create(:note, user: user) }

      before do
        sign_in user
      end

      it "redirects to note#index" do
        delete :destroy, params: { id: note.id }
        expect(response).to redirect_to(note_path)
      end

      it "deletes a note" do
        delete :destroy, params: { id: note.id }
        expect(user.notes.exists?(note.id)).to be_falsy
      end
    end

    context "as an unauthorized user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user) }
      let!(:note) { FactoryGirl.create(:note, user: other_user) }

      before do
        sign_in user
      end

      it "does not delete the note" do
        expect {
          delete :destroy, params: { id: note.id }
        }.to_not change(Note, :count)
      end

      it "redirects to the notes" do
        delete :destroy, params: { id: note.id }
        expect(response).to redirect_to notes_path
      end
    end

    context "as a guest" do
      let!(:note) { FactoryGirl.create(:note) }

      it "returns a 302 response" do
        delete :destroy, params: { id: note.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        delete :destroy, params: { id: note.id }
        expect(response).to redirect_to "/users/sign_in"
      end

      it "does not delete the note" do
        expect {
          delete :destroy, params: { id: note.id }
        }.to_not change(Note, :count)
      end
    end
  end
end
