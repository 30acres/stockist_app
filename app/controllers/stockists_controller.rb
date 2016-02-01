class StockistsController < ApplicationController
  before_action :authenticate_retailer!, only: [:media_center]
  before_filter :load_client, only: [:media_center, :dropbox_download]

  def index
    if params[:search]
      @mapped_stockists = Stockist.search(params[:search]).active.order("name ASC")
      @paged_stockists = @mapped_stockists.page params[:page]
    else
      unless params[:long] && params[:lat]
        @mapped_stockists = Stockist.active.mapped.order('name ASC')
        @paged_stockists = Stockist.active.page params[:page]
      else
        @mapped_stockists = Stockist.active.near([params[:lat].to_f, params[:long].to_f], 30).order('name ASC')
        @paged_stockists = @mapped_stockists.page params[:page]
      end
    end
    @hash = Gmaps4rails.build_markers(@mapped_stockists) do |stockist, marker|
     if stockist.longitude && stockist.latitude 
        marker.lat stockist.latitude
        marker.lng stockist.longitude
        marker.infowindow stockist.map_description
     end
    end
  end

  def show
    @stockist = Stockist.friendly.find(params[:id])
    if @stockist.is_mapped?
      @hash = Gmaps4rails.build_markers([@stockist]) do |stockist, marker|
        marker.lat stockist.slatitude
        marker.lng stockist.slongitude
        marker.infowindow stockist.map_description
      end
    else
      @hash = nil
    end
  end

  def media_center
    @media = 1
  end

  def become_a_stockist
    @media = 1
  end
  
  def dropbox_download
    redirect_to @client.shares(params[:path])["url"]
  end

  private

  def load_client
    require 'dropbox_sdk'
    access_token = 'peIHv38CaNcAAAAAAAC20raFgkju_Is3QDqCWYW1K8hyZcX0shOD-b-nMFZG7DO6'
    @client = DropboxClient.new(access_token)
  end

end
