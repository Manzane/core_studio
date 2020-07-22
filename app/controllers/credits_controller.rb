class CreditsController < ApplicationController
  def index
    @credits = current_user.credits.all
  end
end
