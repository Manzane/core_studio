class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :confidentiality ]

  def home
  end
  
  def confidentiality
  end
end
