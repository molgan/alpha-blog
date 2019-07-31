require 'test_helper'

class SignupUsersTest < ActionDispatch::IntegrationTest
  test 'user should be signed up' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: 'molgan', email: 'molgan@example.com', password: 'password'}}
    end
    follow_redirect!
    assert_template 'users/show'
    assert_match "molgan", response.body
  end
  
  test 'invalid user submission results in failure' do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'Category.count' do
      post users_path, params: {user: {username: 'molgan', email: 'molgan', password: 'password'}}
    end
    assert_template 'users/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end