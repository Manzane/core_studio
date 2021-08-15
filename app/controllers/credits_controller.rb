class CreditsController < ApplicationController
  def index
    @credits = current_user.credits.from_published_categories
  end
end
