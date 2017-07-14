require 'rails_helper'

RSpec.describe EncouragementsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:author) { FactoryGirl.create(:user) }
  let(:note) { FactoryGirl.create(:note, :public_note, user: author) }

  describe "#new" do
    context 'as a guest' do
      it 'is redirected back to note page' do
        get :new, params: { note_id: note.id }
        expect(response).to redirect_to(note_path(note))
      end

      it 'assigns flash message' do
        get :new, params: { note_id: note.id }
        expect(flash[:alert]).to eq('You must be logged in to encourage people')
      end
    end

    context 'as an authenticated user' do
      before { sign_in(user) }

      it 'renders :new template' do
        get :new, params: { note_id: note.id }
        expect(response).to be_success
      end
    end

    context 'note author' do
      before { sign_in(author) }

      it 'is redirected back to note page' do
        get :new, params: { note_id: note.id }
        expect(response).to redirect_to(note_path(note))
      end

      it 'assigns flash message' do
        get :new, params: { note_id: note.id }
        expect(flash[:alert]).to eq("You can't encourage yourself")
      end
    end

    context 'user who already left encouragement for this note' do
      before do
        sign_in(user)
        FactoryGirl.create(:encouragement, user: user, note: note)
      end

      it 'is redirected back to note page' do
        get :new, params: { note_id: note.id }
        expect(response).to redirect_to(note_path(note))
      end

      it 'assigns flash message' do
        get :new, params: { note_id: note.id }
        expect(flash[:alert]).to eq("You already encouraged it. You can't be so generous!")
      end
    end
  end

  describe "#create" do
    let(:encouragement_params) { FactoryGirl.attributes_for(:encouragement) }

    context 'authenticated user' do
      before { sign_in(user) }

      context 'valid data' do
        it 'redirects back to note page' do
          post :create, params: { note_id: note.id, encouragement: encouragement_params }
          expect(response).to redirect_to(note_path(note))
        end

        it 'assigns encouragement to current user and note' do
          post :create, params: { note_id: note.id, encouragement: encouragement_params }
          enc = Encouragement.last
          expect(enc.user).to eq(user)
          expect(enc.note).to eq(note)
        end

        it 'assigns flash message' do
          post :create, params: { note_id: note.id, encouragement: encouragement_params }
          expect(flash[:notice]).to eq('Thank you for encouragement')
        end
      end

      context 'invalid data' do
        let(:invalid_params) { FactoryGirl.attributes_for(:encouragement, message: nil) }
        it 'renders :new template' do
          expect {
            post :create, params: { note_id: note.id, encouragement: invalid_params }
          }.to_not change(Encouragement, :count)
        end
      end
    end

    context 'as a guest user' do
      it 'is redirected back to note page' do
        post :create, params: { note_id: note.id, encouragement: encouragement_params }
        expect(response).to redirect_to(note_path(note))
      end

      it 'assigns flash message' do
        post :create, params: { note_id: note.id, encouragement: encouragement_params }
        expect(flash[:alert]).to eq('You must be logged in to encourage people')
      end
    end

    context 'note author' do
      before { sign_in(author) }

      it 'is redirected back to note page' do
        post :create, params: { note_id: note.id, encouragement: encouragement_params }
        expect(response).to redirect_to(note_path(note))
      end

      it 'assigns flash message' do
        post :create, params: { note_id: note.id, encouragement: encouragement_params }
        expect(flash[:alert]).to eq("You can't encourage yourself")
      end
    end

    context 'user who already left encouragement for this note' do
      before do
        sign_in(user)
        FactoryGirl.create(:encouragement, user: user, note: note)
      end

      it 'is redirected back to note page' do
        post :create, params: { note_id: note.id, encouragement: encouragement_params }
        expect(response).to redirect_to(note_path(note))
      end

      it 'assigns flash message' do
        post :create, params: { note_id: note.id, encouragement: encouragement_params }
        expect(flash[:alert]).to eq("You already encouraged it. You can't be so generous!")
      end
    end
  end
end
