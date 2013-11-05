class BuildingsController < ApplicationController
  before_filter :get_landlord
  
  def get_landlord
    @landlord = Landlord.find(params[:landlord_id])
  end  

  def index
  end  
  
  def new
    @building = @landlord.buildings.new
  end

  def create
    @building = @landlord.buildings.new(building_params)
    if @building.save
      flash[:success] = "Building created!"
      redirect_to @landlord
    else
      render 'new'
    end  
  end

  def destroy
    @building = @landlord.buildings.find(params[:id])
    @building.destroy
    redirect_to @landlord
  end

  private


    def building_params
      params.require(:building).permit(:address, :zip_code, :description)
    end  
end  
