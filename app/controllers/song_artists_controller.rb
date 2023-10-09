class SongArtistsController < ApplicationController
  before_action :set_song_artist, only: %i[ show update destroy ]

  # GET /song_artists
  def index
    @song_artists = SongArtist.all

    render json: @song_artists
  end

  # GET /song_artists/1
  def show
    render json: @song_artist
  end

  # POST /song_artists
  def create
    @song_artist = SongArtist.new(song_artist_params)

    if @song_artist.save
      render json: @song_artist, status: :created, location: @song_artist
    else
      render json: @song_artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /song_artists/1
  def update
    if @song_artist.update(song_artist_params)
      render json: @song_artist
    else
      render json: @song_artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /song_artists/1
  def destroy
    @song_artist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song_artist
      @song_artist = SongArtist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_artist_params
      params.require(:song_artist).permit(:song_id, :artist_id, :primary)
    end
end
