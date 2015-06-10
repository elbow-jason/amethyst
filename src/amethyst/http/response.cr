class Response
  property :body
  property :status_code
  property :headers
  #TODO add cookies

  def initialize(@status_code=nil, @body=nil,@headers=HTTP::Headers.new, @version="HTTP/1.1")
  end

  def header(key, value)
    @headers[key] = value
  end

  # "builds" an HTTP::Response from self
  def build
    return HTTP::Response.new(@status_code, @body, headers = @headers, version = @version)
  end

  def log
    if headers.has_key?("Content-type") && (headers["Content-type"] == ("text/html"||"text/plain"))
      body = @body
    else 
      body = nil
    end
    {
      "status"   :  @status_code,
      "response" :  body
      "version"  :  @version
    }
  end

  def set_cookie(cookie : String)
    headers["Set-Cookie"] = cookie
  end
end