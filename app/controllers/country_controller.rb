class CountryController < ApplicationController

  def show
    @country = Country.friendly.find(params[:id])
    @mapped_stockists = @country.stockists.mapped
    @paged_stockists = @country.stockists.page params[:page]
    @hash = Gmaps4rails.build_markers(@mapped_stockists) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
      marker.infowindow stockist.map_description
    end
  end
end
