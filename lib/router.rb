class Router

  attr_reader :diagnostics,
              :count

  def initialize(diagnostics, count)
    ##Initialize with formatted hash instead of path
    @diagnostics = diagnostics
    @count = count
  end

  def response
    ##Replace path with hash["Path"]
    response = ""
    if diagnostics["Path"] == "/hello"
      response = "<pre>" + "Hello, World! (#{count})" + "</pre>"
    elsif diagnostics["Path"] == "/datetime"
      response = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
    elsif diagnostics["Path"] == "/shutdown"
      response = "Total Requests: #{count}"
    else
      response << "<pre>"
      diagnostics.each do |key, value|
        response << "#{key} : #{value}\n"
      end
        response << "</pre>"
    end

    response
  end
  

end