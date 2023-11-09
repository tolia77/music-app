require "test_helper"

class AlbumArtistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @album_artist = album_artists(:one)
  end

  test "should get index" do
    get album_artists_url, as: :json
    assert_response :success
  end

  test "should create album_artist" do
    assert_difference("AlbumArtist.count") do
      post album_artists_url, params: { album_artist: { album_id: @album_artist.album_id, artist_id: @album_artist.artist_id } }, as: :json
    end

    assert_response :created
  end

  test "should show album_artist" do
    get album_artist_url(@album_artist), as: :json
    assert_response :success
  end

  test "should update album_artist" do
    patch album_artist_url(@album_artist), params: { album_artist: { album_id: @album_artist.album_id, artist_id: @album_artist.artist_id } }, as: :json
    assert_response :success
  end

  test "should destroy album_artist" do
    assert_difference("AlbumArtist.count", -1) do
      delete album_artist_url(@album_artist), as: :json
    end

    assert_response :no_content
  end
end
