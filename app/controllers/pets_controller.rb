class PetsController < ApplicationController
  def index
    pets = Pet.all.order(:name)

    render json: pets.as_json(only: [:id, :name, :age, :owner, :species]), status: :ok
  end

  def show
    pet = Pet.find_by(id: params[:id])

    if pet
      render json: pet.as_json(only: [:id, :name, :age, :owner, :species])
      return
    else
      render json: { ok: false, errors: ["Not Found"] }, status: :not_found
      return
    end
  end
end
