class PackagesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
      @packages = Package.from_published_categories.published
  end
end
