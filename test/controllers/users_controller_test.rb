require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    headers = {}
    @auth_headers_admin = Devise::JWT::TestHelpers.auth_headers(headers, users(:one))
    @auth_headers2 = Devise::JWT::TestHelpers.auth_headers(headers, users(:two))
    @auth_headers3 = Devise::JWT::TestHelpers.auth_headers(headers, users(:three))
  end

  test 'should require authorization' do
    get users_path(users(:one)), as: :json
    assert_response 401
  end

  test 'should show user' do
    get user_path(users(:one)), headers: @auth_headers2, as: :json
    assert_response :success
  end

  test 'should get index' do
    get users_path, headers: @auth_headers_admin, as: :json
    assert_response :success
  end

  test 'should require authorization for index' do
    get users_path, headers: @auth_headers3, as: :json
    assert_response :forbidden
  end
end
