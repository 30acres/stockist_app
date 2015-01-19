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

end
