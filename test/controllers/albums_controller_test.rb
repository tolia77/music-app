require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @album = albums(:one)
    headers = {}
    @auth_headers_admin = Devise::JWT::TestHelpers.auth_headers(headers, users(:admin))
    @auth_headers_moderator = Devise::JWT::TestHelpers.auth_headers(headers, users(:moderator))
    @auth_headers1 = Devise::JWT::TestHelpers.auth_headers(headers, users(:basic1))
    @auth_headers2 = Devise::JWT::TestHelpers.auth_headers(headers, users(:basic2))
  end

  test "should get index" do
    get albums_url, headers: @auth_headers_admin, as: :json
    assert_response :success
  end

  test "should not get index without authorization" do
    get albums_url, as: :json
    assert_response 401
  end

  test "should not get index without authentication" do
    get albums_url, headers: @auth_headers1, as: :json
    assert_response :forbidden
  end

  test "should create album" do
    assert_difference("Album.count") do
      post albums_url, params: { album: { title: @album.title }, artists: [artists(:moderator).id] }, headers: @auth_headers1, as: :json
    end

    assert_response :created
  end

  test "should show album" do
    get album_url(@album), as: :json
    assert_response :success
  end

  test "should update album" do
    patch album_url(@album), params: { album: { title: @album.title } }, headers: @auth_headers1, as: :json
    assert_response :success
  end

  test "should destroy album" do
    assert_difference("Album.count", -1) do
      delete album_url(@album), headers: @auth_headers1, as: :json
    end

    assert_response :no_content
  end
end
