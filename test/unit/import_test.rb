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
        <pubDate>Sun, 30 Nov 2008 16:44:00 +0000</pubDate>
        <wp:post_type>post</wp:post_type>
      </item>
      <item>
        <title>Not a post</title>
        <content:encoded><![CDATA[Hello]]></content:encoded>
        <pubDate>Sun, 30 Nov 2008 16:44:00 +0000</pubDate>
        <wp:post_type>attachement</wp:post_type>
      </item>
      <item>
        <title>Test Post 2</title>
        <pubDate>Sun, 30 Nov 2008 16:44:00 +0000</pubDate>
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
        <pubDate>Sun, 30 Nov 2008 16:44:00 +0000</pubDate>
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
  
  test "imported post has correct date" do
    Import.import_posts_from_rss ComplexPostRss
    assert_equal 1, Post.all.count
    post = Post.all[0]
    assert_equal 2008, post.published_on.year
    assert_equal 11, post.published_on.month
    assert_equal 30, post.published_on.day
  end

  ImageRss = %q{<p>Hello<img src='http://blog.trevorpower.com/wp-content/uploads/2009/10/CopyConfigFiles.png' /> </p>}

  test "importing post with image results in one new image" do
    Import.get_body ImageRss
    assert Image.all.count == 1
    assert_equal 'copyconfigfiles.png', Image.all.first.name
  end

  test "content of imported posts point at imported images" do
    body = Import.get_body ImageRss
    assert body.include?(Image.all.first.url)
  end


  PostWithCommentsRss = %q{<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/"  xmlns:wp="http://wordpress.org/export/1.0/">
    <channel>
      <item>
        <title>Test Post</title>
        <pubDate>Sun, 30 Nov 2008 16:44:00 +0000</pubDate>
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
            <wp:comment_author_url>http://homepage.com/</wp:comment_author_url>
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

  test "imported comments should contain the corrent URL" do
    post = import_post_with_two_comments
    assert_nil post.comments[0].url
    assert_equal "http://homepage.com/", post.comments[1].url
  end

  test "imported comments should contain the corrent dates" do
    post = import_post_with_two_comments
    assert_equal 2009, post.comments[0].published_on.year
    assert_equal 1, post.comments[0].published_on.month
    assert_equal 25, post.comments[0].published_on.day
  end

  test "imported comments should not be published" do
    post = import_post_with_two_comments
    assert_equal false, post.comments[0].published
    assert_equal false, post.comments[1].published
  end

  ComplexPostWithCommentRss = %q{<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/"  xmlns:wp="http://wordpress.org/export/1.0/">
    <channel>
<item>
<title>Have too much money?</title>
<link>http://blog.trevorpower.com/index.php/have-too-much-money/</link>
<pubDate>Thu, 19 Jan 2006 14:45:00 +0000</pubDate>
<dc:creator><![CDATA[trevorpower]]></dc:creator>

		<category><![CDATA[Uncategorized]]></category>

		<category domain="category" nicename="uncategorized"><![CDATA[Uncategorized]]></category>

		<category domain="tag"><![CDATA[Donate]]></category>

		<category domain="tag" nicename="donate"><![CDATA[Donate]]></category>

		<category domain="tag"><![CDATA[Money]]></category>

		<category domain="tag" nicename="money"><![CDATA[Money]]></category>

		<category domain="tag"><![CDATA[Paypal]]></category>

		<category domain="tag" nicename="paypal"><![CDATA[Paypal]]></category>

<guid isPermaLink="false">http://trevorpower.com/blog/?p=14</guid>
<description></description>
<content:encoded><![CDATA[Just give it to me!<br /><br /><center><br /><form action="https://www.paypal.com/cgi-bin/webscr" method="post"><br /><input type="hidden" name="cmd" value="_xclick"><br /><input type="hidden" name="business" value="trevor_power@yahoo.com"><br /><input type="hidden" name="item_name" value="Trevor Power"><br /><input type="hidden" name="item_number" value="TP"><br /><input type="hidden" name="no_note" value="1"><br /><input type="hidden" name="currency_code" value="EUR"><br /><input type="hidden" name="tax" value="0"><br /><input type="hidden" name="bn" value="PP-DonationsBF"><br /><input type="image" src="https://www.paypal.com/en_US/i/btn/x-click-butcc-donate.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!"><br /></form><br /><i>You will be paying securely via PayPal.</i><br /></center>]]></content:encoded>
<excerpt:encoded><![CDATA[]]></excerpt:encoded>
<wp:post_id>14</wp:post_id>
<wp:post_date>2006-01-19 21:45:00</wp:post_date>
<wp:post_date_gmt>2006-01-19 14:45:00</wp:post_date_gmt>
<wp:comment_status>open</wp:comment_status>
<wp:ping_status>open</wp:ping_status>
<wp:post_name>have-too-much-money</wp:post_name>
<wp:status>publish</wp:status>
<wp:post_parent>0</wp:post_parent>
<wp:menu_order>0</wp:menu_order>
<wp:post_type>post</wp:post_type>
<wp:post_password></wp:post_password>
<wp:postmeta>
<wp:meta_key>blogger_blog</wp:meta_key>
<wp:meta_value>blog.trevorpower.com</wp:meta_value>
</wp:postmeta>
<wp:postmeta>
<wp:meta_key>blogger_author</wp:meta_key>
<wp:meta_value>Trevor Powerhttp://www.blogger.com/profile/11004501310130398775noreply@blogger.com</wp:meta_value>
</wp:postmeta>
<wp:postmeta>
<wp:meta_key>blogger_permalink</wp:meta_key>
<wp:meta_value>/2006/01/have-too-much-money.html</wp:meta_value>
</wp:postmeta>
<wp:postmeta>
<wp:meta_key>_edit_lock</wp:meta_key>
<wp:meta_value>1251641737</wp:meta_value>
</wp:postmeta>
<wp:postmeta>
<wp:meta_key>_edit_last</wp:meta_key>
<wp:meta_value>1</wp:meta_value>
</wp:postmeta>
<wp:comment>
<wp:comment_id>5</wp:comment_id>
<wp:comment_author><![CDATA[Trevor Power]]></wp:comment_author>
<wp:comment_author_email></wp:comment_author_email>
<wp:comment_author_url></wp:comment_author_url>
<wp:comment_author_IP></wp:comment_author_IP>
<wp:comment_date>2006-01-19 23:28:00</wp:comment_date>
<wp:comment_date_gmt>2006-01-19 16:28:00</wp:comment_date_gmt>
<wp:comment_content><![CDATA[Thanks, Brian, for your <i>two cents</i>. Unfortunately, paypal took it all for fees.]]></wp:comment_content>
<wp:comment_approved>1</wp:comment_approved>
<wp:comment_type></wp:comment_type>
<wp:comment_parent>0</wp:comment_parent>
<wp:comment_user_id>0</wp:comment_user_id>
</wp:comment>
	</item>
    </channel>
  </rss>
  }

  def import_complex_post_with_one_comment
    Import.import_posts_from_rss ComplexPostWithCommentRss
    assert_equal 1, Post.all.count
    post = Post.all.first
    assert_equal 1, post.comments.count
    post
  end

  test "can import comment from complex post" do
    post = import_complex_post_with_one_comment
  end

end
