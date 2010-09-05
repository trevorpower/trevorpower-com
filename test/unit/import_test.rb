require 'test_helper'
require 'rss/2.0'
require 'rss/maker'

class ImportTest < ActiveSupport::TestCase

  setup do
    Post.collection.remove
    Image.delete_all
  end
  
  MultiplePostsRss = %q{<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/"  xmlns:wp="http://wordpress.org/export/1.0/">
    <channel>
      <item>
        <title>Test Post</title>
        <content:encoded><![CDATA[Hello]]></content:encoded>
        <wp:post_type>post</wp:post_type>
      </item>
      <item>
        <title>Not a post</title>
        <content:encoded><![CDATA[Hello]]></content:encoded>
        <wp:post_type>attachement</wp:post_type>
      </item>
      <item>
        <title>Test Post 2</title>
        <content:encoded><![CDATA[Hello 2]]></content:encoded>
        <wp:post_type>post</wp:post_type>
        </item>
      </channel>
    </rss>
  }

  test "importing posts rss results in two new posts" do
    Import.import_posts_from_rss MultiplePostsRss
    assert_equal 2, Post.all.count
  end

  ComplexPostRss = %q{<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/"  xmlns:wp="http://wordpress.org/export/1.0/">
    <channel>
      <item>
        <title>Test Post</title>
        <content:encoded><![CDATA[<p>Hello</p>]]></content:encoded>
        <wp:post_type>post</wp:post_type>
        <category>Software Development</category>
        <category>Software</category>
        <category domain="category" nicename="software-development">Software Development</category>
        <category domain="tag">Rails</category>
        <category domain="tag">Ruby</category>
      </item>
    </channel>
  </rss>
  }

  test "imported post has correct title" do
    Import.import_posts_from_rss ComplexPostRss
    assert_equal 1, Post.all.count
    assert_equal 'Test Post', Post.all[0].title
  end

  test "imported post has correct body" do
    Import.import_posts_from_rss ComplexPostRss
    assert_equal 1, Post.all.count
    assert_equal '<p>Hello</p>', Post.all[0].body
  end

  test "imported post is draft" do
    Import.import_posts_from_rss ComplexPostRss
    assert_equal 1, Post.all.count
    assert_equal false, Post.all[0].published
  end

  test "imported post has correct published date" do
    Import.import_posts_from_rss ComplexPostRss
    assert_equal 1, Post.all.count
    assert_equal false, Post.all[0].published
  end

  test "imported post has correct tags" do
    Import.import_posts_from_rss ComplexPostRss
    assert_equal 1, Post.all.count
    post = Post.all[0]
    assert_equal 2, post.tags.count
    assert post.tags.include? 'Rails'
    assert post.tags.include? 'Ruby'
  end

  ImageRss = %q{<p>Hello<img src='http://blog.trevorpower.com/wp-content/uploads/2009/10/CopyConfigFiles.png' /> </p>}

  test "importing post with image results in one new image" do
    Import.get_body ImageRss
    assert Image.all.count == 1
    assert Image.all.first.name == 'CopyConfigFiles.png'
  end

  test "content of imported posts point at imported images" do
    body = Import.get_body ImageRss
    assert body.include?(Image.all.first.url)
  end


  PostWithCommentsRss = %q{<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/"  xmlns:wp="http://wordpress.org/export/1.0/">
    <channel>
      <item>
        <title>Test Post</title>
          <wp:comment>
            <wp:comment_author>Trevor Power</wp:comment_author>
            <wp:comment_author_email>email@trevorpower.com</wp:comment_author_email>
            <wp:comment_author_url/>
            <wp:comment_date>2009-01-25 19:56:00</wp:comment_date>
            <wp:comment_date_gmt>2009-01-25 12:56:00</wp:comment_date_gmt>
            <wp:comment_content><![CDATA[This is a comment!]]></wp:comment_content>
          </wp:comment>
          <wp:comment>
            <wp:comment_author>wsctpm</wp:comment_author>
            <wp:comment_author_email>ywtzyj@rxjyjh.com</wp:comment_author_email>
            <wp:comment_author_url>http://jdjvctjptqrr.com/</wp:comment_author_url>
            <wp:comment_date>2010-02-05 15:26:12</wp:comment_date>
            <wp:comment_date_gmt>2010-02-05 15:26:12</wp:comment_date_gmt>
            <wp:comment_content><![CDATA[Hello world!]]></wp:comment_content>
          </wp:comment>
        <content:encoded><![CDATA[<p>Hello</p>]]></content:encoded>
        <wp:post_type>post</wp:post_type>
      </item>
    </channel>
  </rss>
  }

  def import_post_with_two_comments
    Import.import_posts_from_rss PostWithCommentsRss
    assert_equal 1, Post.all.count
    post = Post.all.first
    assert_equal 2, post.comments.count
    post
  end
  
  test "imported comments should contain the corrent body" do
    post = import_post_with_two_comments
    assert_equal "This is a comment!", post.comments[0].body
    assert_equal "Hello world!", post.comments[1].body
  end

  test "imported comments should contain the corrent name" do
    post = import_post_with_two_comments
    assert_equal "Trevor Power", post.comments[0].name
    assert_equal "wsctpm", post.comments[1].name
  end

  test "imported comments should contain the corrent email" do
    post = import_post_with_two_comments
    assert_equal "email@trevorpower.com", post.comments[0].email
    assert_equal "ywtzyj@rxjyjh.com", post.comments[1].email
  end
end
