class EncouragementsController < ApplicationController
  before_action :authenticate_user
  before_action :authors_are_not_allowed
  before_action :only_one_encouragement
  
  def new
    @encouragement = Encouragement.new
  end

  def create
    @encouragement = Encouragement.new(encouragement_params.merge(
      user: current_user,
      note: @note
    ))

    if @encouragement.save
      redirect_to note_path(@note), notice: 'Thank you for encouragement'
    else
      render :new
    end
  end

  private

  def encouragement_params
    params.require(:encouragement).permit(:message)
  end

  def authenticate_user
    @note = Note.find(params[:note_id])

    unless current_user
      redirect_to note_path(@note), alert: 'You must be logged in to encourage people'
      return
    end
  end

  def authors_are_not_allowed
    if current_user.id == @note.user_id
      redirect_to note_path(@note), alert: "You can't encourage yourself"
      return
    end
  end

  def only_one_encouragement
    if Encouragement.exists?(user: current_user, note: @note)
      redirect_to note_path(@note), alert: "You already encouraged it. You can't be so generous!"
      return
    end
  end
end
