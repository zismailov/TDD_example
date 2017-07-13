class NotesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :owner_only, only: [ :edit, :update, :destroy ]

  def index
    @notes = Note.get_public_note
  end

  def new
    @note = Note.new
  end

  def create
    service = NoteCreate.new(note_params, current_user)
    service.call
    if service.created?
      redirect_to note_path(service.note)
    else
      service.note
      render :new
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to note_path(@note)
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to note_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :description, :privacy, :cover_image, :featured)
  end

  def owner_only
    @note = Note.find(params[:id])
    if current_user != @note.user
      redirect_to notes_path
    end
  end
end
