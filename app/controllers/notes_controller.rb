class NotesController < ApplicationController
  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to root_url, notice: "Notes has been created"
    else
      render :new
    end
  end

  def show
    @note = Note.find(params[:id])
    @description = Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(@note.description)
  end

  private

  def note_params
    params.require(:note).permit(:title, :description, :privacy, :cover_image, :featured)
  end
end
