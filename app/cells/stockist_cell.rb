class StockistCell < Cell::ViewModel
  include ApplicationHelper

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

end
