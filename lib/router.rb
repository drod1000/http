require './lib/dictionary'

class Router

  attr_reader :diagnostics,
              :count

  def initialize(diagnostics, count)
    @diagnostics = diagnostics
    @count = count
  end

  def response
    response = ""
    if diagnostics["Path"] == "/hello"
      response = "<pre>" + "Hello, World! (#{count})" + "</pre>"
    elsif diagnostics["Path"] == "/datetime"
      response = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
    elsif diagnostics["Path"] == "/shutdown"
      response = "Total Requests: #{count}"
    elsif diagnostics["Path"] == "/word_search"
    
    else
      response << "<pre>"
      diagnostics.each do |key, value|
        response << "#{key} : #{value}\n"
      end
        response << "</pre>"
    end
    response
  end
  
  def match_in_dictionary
    dictionary = Dictionary.new
    dictionary.find_match(diagnostics["Value"])
  end

end