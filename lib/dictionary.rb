class Dictionary
  dictionary = File.open("/usr/share/dict/words", 'r')
  match = false
  dictionary.each do |word|
    match = true unless "apple" != word.chomp
  end
  match
end
