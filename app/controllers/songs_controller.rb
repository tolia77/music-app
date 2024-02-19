class SongsController < ApplicationController
  before_action :set_song, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create update destroy ]

  # GET /songs
  def index
    @songs = Song.all

    authorize(@songs)
    render json: @songs
  end

  # GET /songs/1
  def show
    render json: @song
  end

  # POST /songs
  def create
    @song = Song.new(song_params)
    authorize(@song)
    if @song.save
      current_user.artist.songs << @song
      if params[:secondary_artists]
        params[:secondary_artists].each do |artist_id|
          Artist.find(artist_id).songs << @song
        end
      end
      render json: @song, status: :created, location: @song
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /songs/1
  def update
    authorize(@song)
    if @song.update(song_params)
      render json: @song
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  # DELETE /songs/1
  def destroy
    authorize(@song)
    @song.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def song_params
      params.require(:song).permit(:title, :secondary_artists)
    end
end
