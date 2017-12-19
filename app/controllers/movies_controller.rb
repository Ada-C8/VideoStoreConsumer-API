class MoviesController < ApplicationController
  before_action :require_movie, only: [:show]

  def index
    if params[:query]
      data = MovieWrapper.search(params[:query])
    else
      data = Movie.all
    end

    render status: :ok, json: data
  end

  def create
    # check movies to see if it exists already?
    @movie = Movie.find_by(title: params[:title])

    # if the movie exists send back
    if @movie
      data = false;
      render(
        status: :bad_request,
        json: data,
      )
    else
      # make a call to the api for movie with external_id?
      # can we just pass in params?
      # create a hash with title, overview, release_date, poster_path, external_id
      MovieWrapper.construct_movie(params)

    end

    render status: :ok, json: data
  end

  def show
    render(
      status: :ok,
      json: @movie.as_json(
        only: [:title, :overview, :release_date, :inventory],
        # methods: [:available_inventory]
        )
      )
  end

  private

  def require_movie
    @movie = Movie.find_by(title: params[:title])
    unless @movie
      render status: :not_found, json: { errors: { title: ["No movie with title #{params["title"]}"] } }
    end
  end
end
