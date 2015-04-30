class CountryController < ApplicationController

  def show
    @country = Country.friendly.find(params[:id])
    @mapped_stockists = @country.stockists.active.mapped.order('city ASC')
    @paged_stockists = @country.stockists.active.page params[:page]
    @hash = Gmaps4rails.build_markers(@mapped_stockists) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
      marker.infowindow stockist.map_description
    end
  end
end
