class ArtsController < ApplicationController
  before_action :set_art, only: [:show, :edit, :update]
  before_action :find_the_arts, only: :show



    def index
      search_word = params[:search]
      @arts = Art.search(search_word)
      # arr = @arts.select { |art| art.title.downcase == search_word.downcase }
      # if arr.empty?
      #   flash[:notice] = "No such a thing exist!"
      # end
    end

    def new
      @art = Art.new
    end

    def create
      @art = Art.new(art_params)
      @art.artist_id = current_artist.id
        if @art.save
          redirect_to "/arts/#{@art.id}"
        else
          render :new
        end
    end

    def show
    end

    def edit

    end

    def update
        if @art.update(art_params)
          redirect_to @art
        else
          render :edit
        end
      end


    def destroy
      set_art.destroy
      flash[:notice] = "deleted"
      redirect_to "/arts"
    end


    private

    def art_params
      params.require(:art).permit(:title, :artist_id, :descrption, :price, :est_date, :img_url, :time_required, :search)
    end

    def set_art
      @art = Art.find_by(id: params[:id])
    end
end
