require 'rails_helper'

RSpec.feature CoverImageUploader do
  it "allows only images" do
    uploader = CoverImageUploader.new(Note.new, :cover_image)
    expect{
      File.open("#{Rails.root}/spec/fixtures/test.gp3") do |f|
        uploader.store!(f)
      end
    }.to raise_exception(CarrierWave::IntegrityError)
  end
end
