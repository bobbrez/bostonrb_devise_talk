class FactsController < ApplicationController
  def index
    render text: 'Cats can rotate their ears 180 degrees each, independently.'
  end
end
