class Note < ApplicationRecord
  belongs_to :user

  validates :title, uniqueness: { scope: :user_id }, presence: true

  enum privacy: [:public_access, :private_access, :friends_access]

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description)
  end
end
