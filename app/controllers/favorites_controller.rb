class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def update
    favorite = Favorite.where(test: Test.find(params[:test]), user: current_user)
    if favorite == []
      favorite_id = Favorite.create(test: Test.find(params[:test]), user: current_user)
      render json: {
        id: favorite_id.test.id,
        text: 'Unfavorite'
      }
    else
      favorite.first.destroy
      render json: {
        id: favorite.first.test.id,
        text: 'Favorite' }
    end
  end
end
