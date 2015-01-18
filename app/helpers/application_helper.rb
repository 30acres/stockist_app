module ApplicationHelper

  def c(param)
    SITE[@site.parameterize][param]
  end

  def custom_partial(path)
    render :partial => "/sites/#{@site}/#{path}" rescue render :partial => path
  end

end
