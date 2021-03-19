class PodcastsController < ApplicationController
  before_action :set_podcast, only: %i[ index show new create edit update destroy ]

  # GET /podcasts or /podcasts.json
  def index
    @podcasts = @service.all
  end

  # GET /podcasts/1 or /podcasts/1.json
  def show
    @podcast = @service.podcast(params[:id])
    @episodes = @service.recent_episodes(@podcast)
  end

  # GET /podcasts/new
  def new
    @podcast = @service.new
  end

  # GET /podcasts/1/edit
  def edit
    @podcast = @service.podcast(params[:id])
  end

  # POST /podcasts or /podcasts.json
  def create

    p = @service.create(podcast_params)
    @podcast = p[:podcast]

    if p[:valid]
      redirect_to @podcast, notice: "Podcast was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
    
  end

  # PATCH/PUT /podcasts/1 or /podcasts/1.json
  def update

    p = @service.update(params[:id], podcast_params)
    @podcast = p[:podcast]

    if p[:valid]
      redirect_to @podcast, notice: "Podcast was successfully created."
    else
      render :new, status: :unprocessable_entity
    end

  end

  # DELETE /podcasts/1 or /podcasts/1.json
  def destroy
    @podcast = @service.podcast(params[:id])
    @service.delete(@podcast)
    redirect_to podcasts_url, notice: "Podcast was successfully destroyed."
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
