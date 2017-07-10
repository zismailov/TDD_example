FactoryGirl.define do
  factory :note do
    sequence(:title) {|n| "Note #{n}"}
    description "Note description"
    privacy Note.privacies[:private_access]
    featured false
    cover_image "image.png"

    factory :public_note do
      privacy Note.privacies[:public_access]
    end

  end
end
