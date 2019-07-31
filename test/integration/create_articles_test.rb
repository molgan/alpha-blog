require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john', email: 'john@example.com', password: 'password')
    @category = Category.create(name: 'sports')
    @category2 = Category.create(name: 'programming')
  end
  
  test 'article should be successfully create' do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {title: 'Testing name', description: 'Testing description', category: [@category, @category2]}}
      follow_redirect!
    end
    assert_template 'articles/show'
    assert_equal "Article was successufully created", flash[:success]
    assert_match 'Testing name', response.body
    assert_match 'Testing description', response.body
  end
  
  test 'invalid article submission results in failure' do
    sign_in_as(@user, 'password')
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, params: {article: {title: ' ', description: ' ', category: []}}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end