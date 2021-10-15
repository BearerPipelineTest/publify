# frozen_string_literal: true

require "publify_core/testing_support/upload_fixtures"

# Factory definitions
FactoryBot.define do
  factory :tag do |tag|
    tag.name { FactoryBot.generate(:name) }
    tag.display_name { |a| a.name } # rubocop:disable Style/SymbolProc
    blog { Blog.first || create(:blog) }
  end

  factory :resource do
    upload { PublifyCore::TestingSupport::UploadFixtures.file_upload }
    mime { "image/jpeg" }
    size { 110 }
    blog { Blog.first || create(:blog) }
  end

  factory :avatar, parent: :resource do
    upload { "avatar.jpg" }
    mime { "image/jpeg" }
    size { 600 }
  end

  factory :redirect do
    from_path { "foo/bar" }
    to_path { "/someplace/else" }
    blog { Blog.first || create(:blog) }
  end

  factory :comment do
    article
    author { "Bob Foo" }
    url { "http://fakeurl.com" }
    body { "Comment body" }
    guid
    state { "ham" }

    factory :unconfirmed_comment do
      state { "presumed_ham" }
    end

    factory :published_comment do
      state { "ham" }
    end

    factory :not_published_comment do
      state { "spam" }
    end

    factory :ham_comment do
      state { "ham" }
    end

    factory :presumed_ham_comment do
      state { "presumed_ham" }
    end

    factory :presumed_spam_comment do
      state { "presumed_spam" }
    end

    factory :spam_comment do
      state { "spam" }
    end
  end

  factory :page do
    name { FactoryBot.generate(:name) }
    title { "Page One Title" }
    body { FactoryBot.generate(:body) }
    published_at { Time.zone.now }
    user
    blog { Blog.first || create(:blog) }
    state { "published" }
  end

  factory :note do
    body { "this is a note" }
    published_at { Time.zone.now }
    user
    state { "published" }
    text_filter_name { "markdown" }
    guid
    blog { Blog.first || create(:blog) }
  end

  factory :unpublished_note, parent: :note do
    state { "draft" }
  end

  factory :trackback do
    state { "ham" }
    article
    blog_name { "Trackback Blog" }
    title { "Trackback Entry" }
    url { "http://www.example.com" }
    excerpt { "This is an excerpt" }
    guid { "dsafsadffsdsf" }
  end

  factory :sidebar do
    active_position { 1 }
    config { { "title" => "Links", "body" => "some links" } }
    type { "StaticSidebar" }
    blog { Blog.first || create(:blog) }
  end
end
