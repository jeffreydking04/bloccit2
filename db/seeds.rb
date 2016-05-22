require 'random_data'

50.times do
  rand(0..1) % 2 == 0 ? bool = true : bool = false
  Question.create!(
    title: RandomData.random_sentence,
    body:  RandomData.random_paragraph,
    resolved: bool
  )
end

puts "Seed finished"
puts "#{Question.count} questions created"
