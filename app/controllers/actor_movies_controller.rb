class ActorMoviesController < ApplicationController
  def create
    ActorMovie.create!(actor_movie_params)

    redirect_to "/movies/#{params[:movie_id]}"
  end

  private

  def actor_movie_params
    params.permit(:actor_id, :movie_id)
  end
end