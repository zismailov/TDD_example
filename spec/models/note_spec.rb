require 'rails_helper'

RSpec.describe Note, type: :model do
  describe "validations" do

    # it 'requires title' do
    #   note = Note.new(title: '')
    #   # note.valid?
    #   # expect(note.errors[:title]).to include("can't be blank")
    #   # expect(note.errors[:title]).not_to be_empty
    #   expect(note.valid?).to be_falsy
    # end

    it { should validate_presence_of(:title) }

    # it 'requires title to be unique for one user' do
    #   user = FactoryGirl.create(:user)
    #   first_note = FactoryGirl.create(:note, :public_note, title: 'First Note', user: user)
    #   new_note = Note.new(title: 'First Note', user: user)
    #   expect(new_note.valid?).to be_falsy
    # end
    #
    # it 'does not allow duplicate Note titles per user' do
    #   user1 = FactoryGirl.create(:user)
    #   user2 = FactoryGirl.create(:user)
    #
    #   first_note = FactoryGirl.create(:note, :public_note, title: 'First Note', user: user1)
    #   new_note = Note.new(title: 'First Note', user: user2)
    #
    #   expect(new_note.valid?).to be_truthy
    # end

     it { should validate_uniqueness_of(:title).scoped_to(:user_id).with_message("you can't have two notes with the same title") }
     it { should validate_presence_of(:user) }
  end

  # Examples withot 'shoulda-matchers'
  #
  # it 'has belongs_to user association' do
  #   # 1 approach
  #   user = FactoryGirl.create(:user)
  #   note = FactoryGirl.create(:note, :public_note, user: user)
  #   expect(note.user).to eq(user)
  #
  #   # 2 approach
  #   u = Note.reflect_on_association(:user)
  #   expect(u.macro).to eq(:belongs_to)
  # end

  it { should belong_to(:user) }
end
