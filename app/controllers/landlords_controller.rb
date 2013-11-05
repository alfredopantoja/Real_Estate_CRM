class LandlordsController < ApplicationController

  def show
    @landlord = Landlord.find(params[:id])
    @buildings = @landlord.buildings.paginate(page: params[:page])
  end

  def new
    @landlord = Landlord.new
  end

  def index 
    @landlords = Landlord.paginate(page: params[:page])
  end  

  def create
    @landlord = Landlord.new(landlord_params)
    if @landlord.save
      flash[:success] = "New landlord created."
      redirect_to @landlord
    else
      render 'new'
    end
  end  

  def edit
    @landlord = Landlord.find(params[:id])
  end  

  def update
    @landlord = Landlord.find(params[:id])
    if @landlord.update_attributes(landlord_params)
      flash[:success] = "Landlord updated."
      redirect_to @landlord
    else
      render 'edit'
    end
  end  

  def destroy
    Landlord.find(params[:id]).destroy
    flash[:success] = "Landlord deleted."
    redirect_to landlords_url
  end

  private

    def landlord_params
      params.require(:landlord).permit(:name, :email, :phone)
    end  
end
