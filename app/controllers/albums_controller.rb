class AlbumsController < ApplicationController
  before_action :set_album, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[create update destroy]

  # GET /albums
  def index
    @albums = Album.all

    render json: @albums
  end

  # GET /albums/1
  def show
    render json: @album
  end

  # POST /albums
  def create
    @album = Album.new(album_params)
    authorize @album
    if @album.save
      current_user.artist.albums << @album
      if params[:songs]
        params[:songs].each do |song_id|
          @album.songs << Song.find(song_id)
        end
      end
      if params[:artists]
        params[:artists].each do |artist_id|
          Artist.find(artist_id).albums << @album
        end
      end
      render json: @album, status: :created, location: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  def update
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def album_params
      params.require(:album).permit(:title, :songs, :artists)
    end
end
