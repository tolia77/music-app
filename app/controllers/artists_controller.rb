class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[ show update destroy ]
  before_action :authenticate_user!
  before_action only: %i[update destroy] do
    authorize(@artist)
  end
  # GET /artists
  def index
    @artists = Artist.all
    render json: @artists
  end

  # GET /artists/1
  def show
    render json: @artist
  end

  # POST /artists
  def create
    @artist = current_user.create_artist(artist_params)
    if @artist.save
      render json: @artist, status: :created, location: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /artists/1
  def update
    if @artist.update(artist_params)
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artists/1
  def destroy
    @artist.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def artist_params
      params.require(:artist).permit(:name, :description, :user_id)
    end
end
