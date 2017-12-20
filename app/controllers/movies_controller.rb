require_dependency '../../lib/movie_wrapper'

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

  def show
    render(
      status: :ok,
      json: @movie.as_json(
        only: [:title, :overview, :release_date, :inventory],
        methods: [:available_inventory]
        )
      )
  end

  def create
    movie_data = MovieWrapper.getMovie(params[:id])
    puts movie_data
    movie = Movie.new do |m|
      m.title = movie_data["title"]
      m.overview = movie_data["overview"]
      m.release_date = movie_data["release_date"]
      m.image_url = movie_data["poster_path"]
    end
    puts movie
    movie.save
  end

  private

  def require_movie
    @movie = Movie.find_by(title: params[:title])
    unless @movie
      render status: :not_found, json: { errors: { title: ["No movie with title #{params["title"]}"] } }
    end
  end
end
