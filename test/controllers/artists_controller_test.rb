require "test_helper"

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:basic1)
    headers = {}
    @auth_headers_admin = Devise::JWT::TestHelpers.auth_headers(headers, users(:admin))
    @auth_headers_moderator = Devise::JWT::TestHelpers.auth_headers(headers, users(:moderator))
    @auth_headers1 = Devise::JWT::TestHelpers.auth_headers(headers, users(:basic1))
    @auth_headers2 = Devise::JWT::TestHelpers.auth_headers(headers, users(:basic2))
  end

  test "should get index" do
    get artists_url, headers: @auth_headers1, as: :json
    assert_response :success
  end

  test "should create artist" do
    assert_difference("Artist.count") do
      post artists_url,
           params: { artist: { description: @artist.description, name: @artist.name, user_id: users(:basic1).id } },
           headers: @auth_headers2,
           as: :json
    end
    assert_response :created
  end

  test 'should not create second artist' do
    assert_raise ActiveRecord::RecordNotUnique do
      post artists_url,
           params: { artist: { description: @artist.description, name: @artist.name, user_id: @artist.user_id } },
           headers: @auth_headers1,
           as: :json
    end
  end

  test "should show artist" do
    get artist_url(@artist), headers: @auth_headers1, as: :json
    assert_response :success
  end

  test "should update artist" do
    patch artist_url(@artist),
          params: { artist: { description: @artist.description, name: @artist.name, user_id: @artist.user_id } },
          headers: @auth_headers1,
          as: :json
    assert_response :success
  end

  test 'should require authorization to update' do
    patch artist_url(@artist),
          params: { artist: { description: @artist.description, name: @artist.name, user_id: @artist.user_id } },
          headers: @auth_headers2,
          as: :json
    assert_response :forbidden
  end

  test "should destroy artist" do
    assert_difference("Artist.count", -1) do
      delete artist_url(@artist),
             headers: @auth_headers1,
             as: :json
    end
    assert_response :no_content
  end

  test 'should require authorization to destroy' do
    delete artist_url(@artist),
             headers: @auth_headers2,
             as: :json
    assert_response :forbidden
  end
end
