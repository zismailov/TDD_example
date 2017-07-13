class Note < ApplicationRecord
  belongs_to :user

  validates :user,  presence: true
  validates :title, uniqueness: {
    scope: :user_id,
    message: "you can't have two notes with the same title"
  },presence: true

  enum privacy: [:public_access, :private_access, :friends_access]

  mount_uploader :cover_image, CoverImageUploader

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end

  def silly_title
    "#{title} by #{user.email}"
  end

  def self.by_letter(letter)
    includes(:user).where("LOWER(title) LIKE ?", "%#{letter.downcase}%").order("users.email")
  end
end
