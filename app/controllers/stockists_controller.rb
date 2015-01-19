class StockistsController < ApplicationController
  def index
    @all_countries = Country.all
    unless params[:long] && params[:lat]
      @mapped_stockists = Stockist.mapped
      @paged_stockists = Stockist.all.page params[:page]
    else
      @mapped_stockists = Stockist.near([params[:lat].to_f, params[:long].to_f], 30)
      @paged_stockists = @mapped_stockists.page params[:page]
    end
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
