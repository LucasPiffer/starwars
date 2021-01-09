class PeopleController < ApplicationController
  def index

  end

  def show
    @person = Person.find(params[:id])
  end
end
