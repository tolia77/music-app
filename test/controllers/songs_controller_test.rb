require "test_helper"

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = songs(:basic1)
    headers = {}
    @auth_headers_admin = Devise::JWT::TestHelpers.auth_headers(headers, users(:admin))
    @auth_headers_moderator = Devise::JWT::TestHelpers.auth_headers(headers, users(:moderator))
    @auth_headers1 = Devise::JWT::TestHelpers.auth_headers(headers, users(:basic1))
    @auth_headers2 = Devise::JWT::TestHelpers.auth_headers(headers, users(:basic2))
  end

  test "should get index" do
    get songs_url, as: :json, headers: @auth_headers_admin
    assert_response :success
  end

  test "should not get index without authorization" do
    get songs_url, as: :json
    assert_response 401
  end

  test "should get index without authentication" do
    get songs_url, as: :json, headers: @auth_headers1
    assert_response :forbidden
  end

  test "should create song" do
    assert_difference("Song.count") do
      post songs_url, params: { song: { title: @song.title } },
           headers: @auth_headers1,
           as: :json
    end

    assert_response :created
  end

  test "should show song" do
    get song_url(@song), as: :json
    assert_response :success
  end

  test "should update song" do
    patch song_url(@song),
          headers: @auth_headers1,
          params: { song: { title: @song.title } }, as: :json
    assert_response :success
  end

  test "should update song as admin" do
    patch song_url(@song),
          headers: @auth_headers_admin,
          params: { song: { title: @song.title } }, as: :json
    assert_response :success
  end

  test "should update song as moderator" do
    patch song_url(@song),
          headers: @auth_headers_moderator,
          params: { song: { title: @song.title } }, as: :json
    assert_response :success
  end

  test "should not update song as other user" do
    patch song_url(@song),
          headers: @auth_headers2,
          params: { song: { title: @song.title } }, as: :json
    assert_response :forbidden
  end

  test "should destroy song" do
    assert_difference("Song.count", -1) do
      delete song_url(@song),
             headers: @auth_headers1,
             as: :json
    end

    assert_response :no_content
  end

  test "should not destroy song as other user" do
    delete song_url(@song),
           headers: @auth_headers2,
           as: :json
    assert_response :forbidden
  end
end
