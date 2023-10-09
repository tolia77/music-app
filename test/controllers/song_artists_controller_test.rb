require "test_helper"

class SongArtistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song_artist = song_artists(:basic1)
  end

  test "should get index" do
    get song_artists_url, as: :json
    assert_response :success
  end

  test "should create song_artist" do
    assert_difference("SongArtist.count") do
      post song_artists_url, params: { song_artist: { artist_id: @song_artist.artist_id, primary: @song_artist.primary, song_id: @song_artist.song_id } }, as: :json
    end

    assert_response :created
  end

  test "should show song_artist" do
    get song_artist_url(@song_artist), as: :json
    assert_response :success
  end

  test "should update song_artist" do
    patch song_artist_url(@song_artist), params: { song_artist: { artist_id: @song_artist.artist_id, primary: @song_artist.primary, song_id: @song_artist.song_id } }, as: :json
    assert_response :success
  end

  test "should destroy song_artist" do
    assert_difference("SongArtist.count", -1) do
      delete song_artist_url(@song_artist), as: :json
    end

    assert_response :no_content
  end
end
