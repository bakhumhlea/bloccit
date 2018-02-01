require 'random_data'

50.times do
    Post.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
    )
end
posts = Post.all

100.times do
    Comment.create!(
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end

20.times do
    Advertisement.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        price: RandomData.random_price
    )
end

23.times do
    Question.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: false
    ) 
end

questions = Question.all

40.times do
    Answer.create!(
        question: questions.sample,
        body: RandomData.random_paragraph
    ) 
end

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} ads created"
puts "#{Question.count} questions created"
puts "#{Answer.count} answers created"