class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @favorite = current_user.favorites.create(output_id: params[:output_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @output = Output.find(params[:output_id])
    @favorite = current_user.favorites.find_by(output_id: @output.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end
end