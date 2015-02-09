module ApplicationHelper

  def c(param)
    SITE[@site.parameterize][param]
  end

  def custom_partial(path)
    render :partial => "/sites/#{@site}/#{path}" rescue render :partial => path
  end

  def is_phillipines?
    @country_domain && @country_domain == 'ph'
  end

end
