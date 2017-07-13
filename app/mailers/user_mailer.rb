class UserMailer < ApplicationMailer
  def note_created(email, note_id)
    @note_id = note_id
    mail to: email, subject: 'Zaebisi with your new note!'
  end
end
