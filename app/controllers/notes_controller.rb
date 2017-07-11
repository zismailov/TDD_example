class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to note_url(@note), notice: "Notes has been created"
    else
      render :new
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  private

  def note_params
    params.require(:note).permit(:title, :description, :privacy, :cover_image, :featured)
  end
end
