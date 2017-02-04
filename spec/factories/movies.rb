FactoryGirl.define do
  factory :movie do
    name 'movie1'
    director 'director1'
    synopsis 'synopsis1'
    stock 1
    poster File.new('spec/fixtures/test-img.png')
  end
end