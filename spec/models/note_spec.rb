require 'rails_helper'

RSpec.describe Note, type: :model do
  describe "validations" do
    it 'requires title' do
      note = Note.new(title: '')
      # note.valid?
      # expect(note.errors[:title]).to include("can't be blank")
      # expect(note.errors[:title]).not_to be_empty
      expect(note.valid?).to be_falsy
    end

    it 'requires title to be unique for one user' do
      user = FactoryGirl.create(:user)
      first_note = FactoryGirl.create(:note, :public_note, title: 'First Note', user: user)
      new_note = Note.new(title: 'First Note', user: user)
      expect(new_note.valid?).to be_falsy
    end

    it 'does not allow duplicate Note titles per user' do
      user1 = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)

      first_note = FactoryGirl.create(:note, :public_note, title: 'First Note', user: user1)
      new_note = Note.new(title: 'First Note', user: user2)

      expect(new_note.valid?).to be_truthy
    end
  end
end
