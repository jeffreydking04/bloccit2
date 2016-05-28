FactoryGirl.define do
  factory :comment do
    body RandomData.random_paragraph
    topic
    post
    user
  end
end