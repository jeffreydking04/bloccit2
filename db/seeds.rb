require 'random_data'

50.times do
  Advertisement.create!(
    title: RandomData.random_word.capitalize,
    body:  RandomData.random_sentence.capitalize,
    price: rand(2..10)
  )
end

puts "Seed finished"
puts "#{Advertisement.count} advertisements created"
