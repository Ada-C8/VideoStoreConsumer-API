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
    movie = Movie.find_by(title: params[:title])

    # if the movie exists send back
    if movie
      render status: :not_found, json: { errors: { title: ["The movie #{params["title"]} has already been added to our Library."] } }
    else
      new_movie = MovieWrapper.construct_movie(params)
      new_movie.save
      render status: :ok, json: data
    end
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
