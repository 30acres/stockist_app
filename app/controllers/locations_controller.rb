class LocationsController < ApplicationController

  respond_to :html




  def create
    already_location = Location.where(name: params[:location][:name]).any?
    if already_location
      @location = Location.where(name: params[:location][:name]).first
    else
      @location=Location.new(permitted_params)
      @location.save
    end

    respond_with(@location)
  end

  

     

  def show
      @location = Location.find(params[:id])
    
    
        @mapped_stockists = Stockist.near([@location.latitude, @location.longitude], 10).order('name ASC')
        @paged_stockists = @mapped_stockists.page params[:page]

    @hash = Gmaps4rails.build_markers(@mapped_stockists) do |stockist, marker|
     if stockist.longitude && stockist.latitude 
        marker.lat stockist.latitude
        marker.lng stockist.longitude
        marker.infowindow stockist.map_description
     end
    end
    ##respond_with(@location)
  end

def permitted_params
params.require(:location ).permit([:name])
end


end
