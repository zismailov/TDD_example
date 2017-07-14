class Api::NotesController < ApiController
  def index
    note = Note.public_access
    render json: note
  end
end
