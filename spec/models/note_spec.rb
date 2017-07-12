require 'rails_helper'

RSpec.describe Note, type: :model do
  describe "validations" do
    it { should validate_presence_of(:title) }
     it { should validate_uniqueness_of(:title).scoped_to(:user_id).with_message("you can't have two notes with the same title") }
     it { should validate_presence_of(:user) }
  end

  describe "association" do
    it { should belong_to(:user) }
  end

  describe "instance methods" do
    it 'converts markdown to html' do
      note = Note.new(description: 'Awesome **some** make *noise*')
      expect(note.description_html).to include('<strong>some</strong>')
      expect(note.description_html).to include('<em>noise</em>')
    end

    it 'has silly title' do
      note = Note.new(title: 'New note', user: FactoryGirl.create(:user, email: 'test@email.com'))
      expect(note.silly_title).to eq('New note by test@email.com')
    end
  end
end
