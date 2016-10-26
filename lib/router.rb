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
      response = word_search(diagnostics["Value"])
    elsif diagnostics["Path"] == "/start_game"
      response = "Good luck!"
    else
      response << "<pre>"
      diagnostics.each do |key, value|
        response << "#{key} : #{value}\n"
      end
        response << "</pre>"
    end
    response
  end
  
  def match_in_dictionary(word)
    dictionary = Dictionary.new
    dictionary.find_match(word)
  end

  def word_search(word)
    match = ""
    if match_in_dictionary(word)
      match = "#{word} is a known word."
    else
      match = "#{word} is not a known word."
    end
  end


end