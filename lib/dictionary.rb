class Dictionary
  
  def find_match(given_word)
    words = File.open("/usr/share/dict/words", 'r')
    match = words.find do |word|
      word.chomp == given_word
    end
  end
end
