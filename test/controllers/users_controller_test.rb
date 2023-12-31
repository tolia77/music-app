require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    headers = {}
    @auth_headers_admin = Devise::JWT::TestHelpers.auth_headers(headers, users(:admin))
    @auth_headers_moderator = Devise::JWT::TestHelpers.auth_headers(headers, users(:moderator))
    @auth_headers1 = Devise::JWT::TestHelpers.auth_headers(headers, users(:basic1))
    @auth_headers2 = Devise::JWT::TestHelpers.auth_headers(headers, users(:basic2))
  end

  test 'should require authorization' do
    get users_path(users(:basic1)), as: :json
    assert_response 401
  end

  test 'should show user' do
    get user_path(users(:basic1)), headers: @auth_headers2, as: :json
    assert_response :success
  end

  test 'should get index' do
    get users_path, headers: @auth_headers_admin, as: :json
    assert_response :success
  end

  test 'should require authorization for index' do
    get users_path, headers: @auth_headers1, as: :json
    assert_response :forbidden
  end
end
