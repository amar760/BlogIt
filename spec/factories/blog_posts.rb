FactoryBot.define do
    factory :blog_post do
      title { "Sample Blog Post" }
      description { "This is a sample blog post description." }
      association :user  # Automatically creates a user if not provided
    end
end