class StockistsController < ApplicationController
  def index
    @all_countries = Country.all
    @paged_stockists = Stockist.all.page params[:page]
    @hash = Gmaps4rails.build_markers(@paged_stockists.mapped) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
    end
  end

  def show
    @stockist = Stockist.friendly.find(params[:id])
    if @stockist.is_mapped?
      @hash = Gmaps4rails.build_markers([@stockist]) do |stockist, marker|
        marker.lat stockist.latitude
        marker.lng stockist.longitude
      end
    else
      @hash = nil
    end
  end
end
