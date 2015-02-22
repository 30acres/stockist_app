class StockistCell < Cell::ViewModel
  include ApplicationHelper
  include FontAwesome::Rails::IconHelper

  def initialize(*args)
    super
    @site = options[:site] 
  end

  def show
    render
  end

  def teaser
    render
  end

  private
  property :name
  property :address

  def logo
    image_tag(c('logo'))
  end

  def stockist_url
    stockist_path(model)
  end

  def stockist_id
    "stockist_#{model.id}"
  end

  def clean_name
    model.to_s.titleize.html_safe
  end

  def page_title
    "Find #{c('site_name')} #{c('site_meta')} at #{clean_name} in #{model.city}"
  end

end
