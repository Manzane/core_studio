class PackagesController < ApplicationController
  before_action :set_package, only: [:show]
  def index
      @Packages = Package.all
  end

  def show
      # raise
  end

  private

  def set_package
    @package = package.find(params[:id])
  end
end
