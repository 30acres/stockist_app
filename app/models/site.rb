class Site
  attr_reader :code

  def initialize(request_host, session_cookie)
    @url_code = request_host
    @cookie_code ||= session_cookie
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

end
