class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :get_site, :all_sites, :all_countries

  WEBSITE = @site

  def get_site
    @site = Site.new(request.host, site_code).current_site
  end

  def site_code
    cookies[:site_code] ||= { 
       :value => 'eyeofhorus',
       :expires => 1.year.from_now,
       :domain => request.host
    }[:value]
  end

  def all_sites
    @sites = SITE.map {|l| l[0] }
  end

  def all_countries
    @all_countries = Country.all
  end
  
end
