include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :movie do
    name 'movie1'
    director 'director1'
    synopsis 'synopsis1'
    stock 1
    poster { fixture_file_upload "#{Rails.root}/spec/fixtures/test-img.png", 'image/png' }
  end
end