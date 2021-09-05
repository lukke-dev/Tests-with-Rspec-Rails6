class WeaponsController < ApplicationController
  def index
    @weapons = Weapon.all
  end

  def create
    weapon = Weapon.new(weapon_params)
    if weapon.save
      flash[:notice] = 'arma criada com sucesso'
      redirect_to weapon
    else
      redirect_to 'index'
    end
  end

  def destroy
    weapon = Weapon.find(params[:id])
    weapon.destroy
  end

  def show
    @weapon = Weapon.find(params[:id])
  end

  private

  def weapon_params
    params.require(:weapon).permit(:name, :description, :power_base, :power_step, :level)
  end
end
