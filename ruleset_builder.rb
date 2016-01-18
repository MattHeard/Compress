words = File.read('words.txt').split
symbol_chars = File.read('ascii.txt').split

new_array = symbol_chars.map do |symbol_char|
  [symbol_char, "1"+symbol_char]
end

# File.write("escaped_chars_pairs.rb", new_array)

words += words.map { |word| word.capitalize }
File.write("ruleset_symbols_to_esc.rb", new_array)
File.write("ruleset_word_to_symbol.rb", words.zip(symbol_chars))

# File.write("ruleset.rb", words.zip(symbol_chars))


# File.write("words.txt", words.join("\n"))

# File.write("ruleset.rb", words.zip(symbol_chars))
