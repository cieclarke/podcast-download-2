class PodcastsController < ApplicationController
  before_action :set_podcast, only: %i[ index show new create edit update destroy ]

  # GET /podcasts or /podcasts.json
  def index
    @podcasts = @service.all
  end

  # GET /podcasts/1 or /podcasts/1.json
  def show
    @podcast = @service.podcast(params[:id])
  end

  # GET /podcasts/new
  def new
    @podcast = @service.new
  end

  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts or /podcasts.json
  def create

    p = @service.save_podcast(podcast_params)

    respond_to do |format|
      if p[:saved]
        format.html { redirect_to action: "index", notice: "Podcast was successfully created." }
        format.json { render :show, status: :created, location: @podcast }
      else
        @podcast = p[:podcast]
        format.html { render :action => :new, :locals => {:podcast => p[:podcast]}  }
        format.json { render json: p[:errors], status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcasts/1 or /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to :index, notice: "Podcast was successfully updated." }
        format.json { render :show, status: :ok, location: @podcast }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1 or /podcasts/1.json
  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to podcasts_url, notice: "Podcast was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def permitted_params
    params.permit(:artist, :album, :recent, :url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @service = Services::PodcastService.new
    end

    # Only allow a list of trusted parameters through.
    def podcast_params
      params.require(:podcast).permit(:artist, :album, :url, :recent)
    end
end
