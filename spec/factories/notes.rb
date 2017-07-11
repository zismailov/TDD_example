FactoryGirl.define do
  factory :note do
    sequence(:title) {|n| "Note #{n}"}
    description "Note description"
    featured false
    cover_image "image.png"

    trait :invalid do
      title nil
    end

    trait :public_note do
      privacy :public_access
    end

    trait :private_note do
      privacy :private_access
    end

  end
end
