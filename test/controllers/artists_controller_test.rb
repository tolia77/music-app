require "test_helper"

class ArtistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artist = artists(:one)
    headers = {}
    @auth_headers1 = Devise::JWT::TestHelpers.auth_headers(headers, users(:one))
    @auth_headers2 = Devise::JWT::TestHelpers.auth_headers(headers, users(:two))
    @auth_headers3 = Devise::JWT::TestHelpers.auth_headers(headers, users(:three))
  end

  test "should get index" do
    get artists_url, as: :json
    assert_response :success
  end

  test "should create artist" do
    assert_difference("Artist.count") do
      post artists_url,
           params: { artist: { description: @artist.description, name: @artist.name, user_id: users(:three).id } },
           headers: @auth_headers3,
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
    get artist_url(@artist), as: :json
    assert_response :success
  end

  test "should update artist" do
    patch artist_url(@artist),
          params: { artist: { description: @artist.description, name: @artist.name, user_id: @artist.user_id } },
          headers: @auth_headers1,
          as: :json
    assert_response :success
  end

  test "should destroy artist" do
    assert_difference("Artist.count", -1) do
      delete artist_url(@artist),
             headers: @auth_headers1,
             as: :json
    end

    assert_response :no_content
  end
end
