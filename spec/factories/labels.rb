FactoryGirl.define do
  factory :label do
    name RandomData.random_word
    user
    post
    topic
  end
end