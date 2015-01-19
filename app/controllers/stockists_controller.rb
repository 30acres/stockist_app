class StockistsController < ApplicationController
  def index
    @all_countries = Country.all
    @mapped_stockists = Stockist.mapped
    @paged_stockists = Stockist.all.page params[:page]
    @hash = Gmaps4rails.build_markers(@mapped_stockists) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
      marker.infowindow stockist.map_description
    end
  end

  def show
    @stockist = Stockist.friendly.find(params[:id])
    if @stockist.is_mapped?
      @hash = Gmaps4rails.build_markers([@stockist]) do |stockist, marker|
        marker.lat stockist.latitude
        marker.lng stockist.longitude
        marker.infowindow stockist.map_description
      end
    else
      @hash = nil
    end
  end
end
