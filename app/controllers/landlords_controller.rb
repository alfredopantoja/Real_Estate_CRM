class LandlordsController < ApplicationController

  def show
    @landlord = Landlord.find(params[:id])
  end

  def new
    @landlord = Landlord.new
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

  private

    def landlord_params
      params.require(:landlord).permit(:name, :email, :phone)
    end  
end
