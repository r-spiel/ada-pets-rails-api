class PetsController < ApplicationController
  def index
    @pets = Pet.all.order(:name)

    render json: { ok: 'YASS'}, status: :ok
  end
end
