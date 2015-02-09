class Site
  attr_reader :code

  def initialize(request_host, session_cookie=nil)
    @url_code = request_host
    @cookie_code ||= session_cookie
    @cookie_code_subdomain ||= 'phillipines'
  end

  def current_site
    if Rails.env.development?
      ## Use the cookies to set the site in dev
      @cookie_code
    else
      ## Use the URLs to set the site in prod etc
      @url_code.split('.').select {|c| c.length > 4 }.last
    end
  end

  def subdomain
    if Rails.env.development?
      ## Use the cookies to set the site in dev
      @cookie_code_subdomain
    else
      ## Use the URLs to set the site in prod etc
      @url_code.split('.').select {|c| c.length > 4 }.first
    end
  end

  def country_domain
    # 'ph'
    @url_code.split('.').select {|c| c.length == 2 }.first
  end

end
