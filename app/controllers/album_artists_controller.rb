class AlbumArtistsController < ApplicationController
  before_action :set_album_artist, only: %i[ show update destroy ]

  # GET /album_artists
  def index
    @album_artists = AlbumArtist.all

    render json: @album_artists
  end

  # GET /album_artists/1
  def show
    render json: @album_artist
  end

  # POST /album_artists
  def create
    @album_artist = AlbumArtist.new(album_artist_params)

    if @album_artist.save
      render json: @album_artist, status: :created, location: @album_artist
    else
      render json: @album_artist.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /album_artists/1
  def update
    if @album_artist.update(album_artist_params)
      render json: @album_artist
    else
      render json: @album_artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /album_artists/1
  def destroy
    @album_artist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album_artist
      @album_artist = AlbumArtist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_artist_params
      params.require(:album_artist).permit(:album_id, :artist_id)
    end
end
