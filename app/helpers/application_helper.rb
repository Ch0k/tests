module ApplicationHelper
  def favorite_helper(test, user)
    if Favorite.where(test: test, user: user) == []
      return "Favorite"
    else
      return "Unfavorite"
    end
  end
end
