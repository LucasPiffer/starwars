class PeopleController < ApplicationController
  def index
    @people = Person.paginate(page: params[:page], per_page: 20)
  end

  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.js
    end
  end
end
