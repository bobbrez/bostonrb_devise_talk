class FactsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    render text: "Did you know #{ current_user.email } that Cats can rotate their ears 180 degrees each, independently."
  end
end
