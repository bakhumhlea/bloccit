require 'random_data'

5.times do
    User.create!(
        name:     RandomData.random_name,
        email:    RandomData.random_email,
        password: RandomData.random_sentence
    )
    end
users = User.all
 
15.times do
    Topic.create!(
        name: RandomData.random_sentence,
        description: RandomData.random_paragraph
    )
end

topics = Topic.all

15.times do
    sponsored_post = SponsoredPost.create!(
        user: users.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        price: RandomData.random_price,
        topic: topics.sample
    )
    sponsored_post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
    rand(1..5).times { sponsored_post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end
 
50.times do
    post = Post.create!(
        user: users.sample,
        topic:  topics.sample,
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph
    )
    post.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
    rand(1..5).times { post.votes.create!(value: [-1, 1].sample, user: users.sample) }
end

posts = Post.all
sponsoredposts = SponsoredPost.all

40.times do
    Comment.create!(
        user: users.sample,
        post: posts.sample,
        body: RandomData.random_paragraph
    )
end
150.times do
    Comment.create!(
        user: users.sample,
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

admin = User.create!(
    name:     'Admin User',
    email:    'admin@example.com',
    password: 'helloworld',
    role:     'admin'
)


member = User.create!(
    name:     'Member User',
    email:    'member@example.com',
    password: 'helloworld'
)
moderator = User.create!(
    name:     'Moderator!',
    email:    'moderator@bloccit.com',
    password: 'helloworld',
    role:     'moderator'
)

puts "Seed finished"
puts "#{User.count} users created"
puts "#{admin.name} was created"
puts "#{member.name} was created"
puts "#{moderator.name} was created"
puts "#{Topic.count} topics created"
puts "#{SponsoredPost.count} sponsored posts created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
puts "#{Advertisement.count} ads created"
puts "#{Question.count} questions created"
puts "#{Answer.count} answers created"
puts "#{Vote.count} votes created"