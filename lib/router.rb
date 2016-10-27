require './lib/dictionary'
require './lib/game'

class Router
  attr_accessor :game

  def initialize
    @game = nil
  end

  def response(diagnostics, count)
    response = ""
    if diagnostics["Verb"] == "GET"
      response = get_response(diagnostics, count)
    elsif diagnostics["Verb"] == "POST"
      response = post_response(diagnostics, count)
    end
    response
  end

  def post_response(diagnostics, count)
    response = ""
    if diagnostics["Path"] == "/start_game"
      start_game
      response = "Good luck!"
    elsif diagnostics["Path"] == "/game"
      response = game.guess_number(diagnostics["Value"].to_i)
    end
    response
  end

  def get_response(diagnostics, count)
    response = ""
    if diagnostics["Path"] == "/hello"
      response = "<pre>" + "Hello, World! (#{count})" + "</pre>"
    elsif diagnostics["Path"] == "/datetime"
      response = Time.now.strftime('%e %b %Y %H:%M:%S%p').to_s
    elsif diagnostics["Path"] == "/shutdown"
      response = "Total Requests: #{count}"
    elsif diagnostics["Path"] == "/word_search"
      response = word_search(diagnostics["Value"])
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
  def start_game
    @game = Game.new
  end

end