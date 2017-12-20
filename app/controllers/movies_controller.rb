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

  def top
    data = MovieWrapper.top10()
    render status: :ok, json: data
  end

  def show
    render(
      status: :ok,
      json: @movie.as_json(
        only: [:title, :overview, :release_date, :inventory],
        methods: [:available_inventory, :image_url]
        )
      )
  end

  def create
    data = MovieWrapper.search(params[:title])
    parsed_date = Date.parse(params[:release_date])
    data.each do |movie|
      if movie[:title] == params[:title] && movie[:release_date] == parsed_date
        movie['inventory'] = 0
        if movie.save
          render json: movie.as_json(), status: :ok #only: [:title, :overview, :release_date, :inventory, :image_url]
        else
          render json: { errors: movie.errors.messages }, status: :bad_request
        end
      end
    end
  end

  # def update
  #   @movie.update_attributes(:available_inventory => params[:inventory])
  # end

  private

  def require_movie
    @movie = Movie.find_by(title: params[:title])
    unless @movie
      render status: :not_found, json: { errors: { title: ["No movie with title #{params["title"]}"] } }
    end
  end

  def movie_params
    params.permit(:title, :release_date)
  end
end
