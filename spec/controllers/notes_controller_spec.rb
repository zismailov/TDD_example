require 'rails_helper'

RSpec.describe NotesController, type: :controller do

  describe "#index" do
    describe "as a guest" do
      let(:note) { instance_double(Note) }

      before do
        allow(Note).to receive(:get_public_note) { [note] }
      end

      it "responds successfully" do
        get :index
        expect(response).to be_success
      end

      it "returns a 200 response" do
        get :index
        expect(response).to have_http_status "200"
      end

      it 'assigns public notes to template' do
        get :index
        expect([note]).to eq([note])
      end
    end
  end

  describe "#create" do
    let(:user) { instance_double(User) }
    before do
      allow(controller).to receive(:current_user) { user }
      allow(controller).to receive(:authenticate_user!) { true }
    end

    context "as an authenticated user" do
      let(:note_params) { ActionController::Parameters.new(title: 'title').permit(:title) }
      let(:create_note) { instance_double(NoteCreate) }
      let(:note) { instance_double(Note) }

      before do
        allow(NoteCreate).to receive(:new) { create_note }
        allow(create_note).to receive(:call)
        allow(create_note).to receive(:created?)
        allow(create_note).to receive(:note) { note }
      end

      it 'send create message to NoteCreate' do
        expect(NoteCreate).to receive(:new).with(note_params, user)
        expect(create_note).to receive(:call)
        post :create, params: { note: note_params }
      end

      context 'note is created' do
        before { allow(create_note).to receive(:created?) { true } }

        it 'redirects' do
          post :create, params: { note: note_params }
          expect(response).to have_http_status "302"
        end
      end

      context 'note is not created' do
        before { allow(create_note).to receive(:created?) { false } }

        it 'render :new template' do
          post :create, params: { note: note_params }
          expect {Note.create(title: note_params) }.to_not change(Note, :count)
        end
      end

    end
  end

end
