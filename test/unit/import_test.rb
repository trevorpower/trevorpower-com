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
      </item>
    </channel>
  </rss>
  }

  test "importing complex post rss results in one new posts" do
    Import.import_posts_from_rss ComplexPostRss
    assert Post.all.count == 1
  end
  
  test "imported post has correct title" do
    Import.import_posts_from_rss ComplexPostRss
    assert Post.all[0].title == 'Test Post'
  end

  test "imported post has correct body" do
    Import.import_posts_from_rss ComplexPostRss
    assert_equal '<p>Hello</p>', Post.all[0].body
  end

  test "imported post is draft" do
    Import.import_posts_from_rss ComplexPostRss
    assert_equal false, Post.all[0].published
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

end
