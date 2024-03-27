class ArtistsController < ApplicationController
    before_action :set_artist, only: [:show, :update, :destroy]

    # GET /tasks
    def index
      @artists = Artist.all
      render json: @artists
    end

    def show
        render json: @artist
    end

    def update
        if(@artist.update(artist_params))
            render json: @artist
        else
            render json: @artist.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @artist.destroy
    end

    # POST /tasks
    def create
        @artist = Artist.new(artist_params)

        if @artist.save
            render json: @artist, status: :created, location: @artist
        else
            render json: @artist.errors, status: :unprocessable_entity
        end
    end


    private
    def set_artist
        @artist = Artist.find(params[:id])
    end

    def artist_params
        params.require(:artist).permit(:first_name, :last_name, :genre)
    end
end
