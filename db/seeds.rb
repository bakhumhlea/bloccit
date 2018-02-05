require 'random_data'

15.times do
    Topic.create!(
        name: RandomData.random_sentence,
        description: RandomData.random_paragraph
    )
end

topics = Topic.all

50.times do
    SponsoredPost.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        price: RandomData.random_price,
        topic: topics.sample
    )
end
 
50.times do
    Post.create!(
        topic:  topics.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
    )
end
posts = Post.all
sponsoredposts = SponsoredPost.all

50.times do
    Comment.create!(
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end
50.times do
    Comment.create!(
        sponsored_post: sponsoredposts.sample,
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
puts "#{Topic.count} topics created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} ads created"
puts "#{Question.count} questions created"
puts "#{Answer.count} answers created"