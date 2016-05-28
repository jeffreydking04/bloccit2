FactoryGirl.define do
  factory :post do
    value [-1, 1].sample
    user
    post
  end
end