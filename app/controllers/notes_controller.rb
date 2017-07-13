class NotesController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :owner_only, only: [ :edit, :update, :destroy ]

  def index
    @notes = Note.public_access
  end

  def new
    @note = Note.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      UserMailer.note_created(current_user.email, @note.id).deliver_now
      redirect_to note_url(@note), notice: "Notes has been created"
    else
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
