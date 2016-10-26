class Decision

  attr_reader :path,
              :count

  def initialize(path, count)
    @path = path
    @count = count
  end

  def response
    response = ""
    if path == "/hello"
      response = "<pre>" + "Hello, World! (#{count})" + "</pre>"
    elsif path == "/datetime"
      response = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
    elsif path == "/shutdown"
      response = "Total Requests: #{count}"
    end
    response
  end

end