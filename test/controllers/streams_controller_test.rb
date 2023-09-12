require "test_helper"

class TurboRailsGem::StreamsControllerTest < ActionDispatch::IntegrationTest
  test "create article action as html redirects to articles path" do
    post articles_path, params: { article: { content: "hello world" } }

    assert_redirected_to articles_path
  end

  test "create article as turbo stream prepends article to articles div" do
    post articles_path, params: { article: { content: "hello world" } }, as: :turbo_stream

    assert_turbo_stream action: "prepend", target: "articles"
  end

  test "update article action as html redirects to articles path" do
    article = Article.create! content: "hello world"
    patch article_path(article), params: { article: { content: "good bye world" } }
    
    assert_redirected_to articles_path
  end

  test "update article action as turbo stream replaces the article" do
    article = Article.create! content: "hello world"
    patch article_path(article), params: { article: { content: "good bye world" } }, as: :turbo_stream

    assert_turbo_stream action: "replace", target: article
  end

  test "destroy article action as html redirects to articles path" do
    article = Article.create! content: "hello world"
    delete article_path(article)

    assert_redirected_to articles_path
  end

  test "destroy article action as turbo stream removes the article" do
    article = Article.create! content: "hello world"
    delete article_path(article), as: :turbo_stream

    assert_turbo_stream action: "remove", target: article
  end

  test "show all turbo actions" do
    article = Article.create! content: "hello world"
    get article_path(article), as: :turbo_stream

    assert_dom_equal <<~HTML, @response.body
      <turbo-stream action="remove" target="#{dom_id(article)}"></turbo-stream>
      <turbo-stream action="update" target="#{dom_id(article)}"><template>#{render(article)}</template></turbo-stream>
      <turbo-stream action="replace" target="#{dom_id(article)}"><template>A random string</template></turbo-stream>
      <turbo-stream action="prepend" target="articles"><template>#{render(article)}</template></turbo-stream>
      <turbo-stream action="prepend" target="articles"><template>#{render(article)}</template></turbo-stream>
    HTML
  end
end