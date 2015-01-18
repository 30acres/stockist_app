class CountryController < ApplicationController

  def show
    @country = Country.friendly.find(params[:id])
    @paged_stockists = @country.stockists.page params[:page]
    @hash = Gmaps4rails.build_markers(@paged_stockists) do |stockist, marker|
      marker.lat stockist.latitude
      marker.lng stockist.longitude
    end
  end
end
