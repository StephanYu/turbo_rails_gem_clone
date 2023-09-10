require "test_helper"

class TurboRailsGem::FramesHelperTest < ActionView::TestCase

  test "turbo_frame_tag with an article resource" do
    article = Article.new(id: 1, content: "Hello, Test!")
    assert_dom_equal %(<turbo-frame id="article_1"></turbo-frame>), turbo_frame_tag(article)
  end

  test "turbo_frame_tag with a string resource" do
    string = "article"
    assert_dom_equal %(<turbo-frame id="article"></turbo-frame>), turbo_frame_tag(string)
  end

  test "turbo_frame_tag with a block" do
    article = Article.new(id: 1, content: "Hello, Test!")
    assert_dom_equal %(<turbo-frame id="article_1"><div>Hello, Test!</div></turbo-frame>), turbo_frame_tag(article) { tag.div(article.content) }
  end
end
