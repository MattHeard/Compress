require_relative 'ruleset_symbols_to_esc'
require_relative 'ruleset_word_to_symbol'

class Compressor
  def initialize(text)
    @text = text
    @words_ruleset = WORDS_RULESET
    @symbols_ruleset = SYMBOLS_RULESET
  end

  # def substitute(ruleset)
  #   ruleset.each do |rule|
  #     apply_rule(rule)
  #   end
  #   @text
  # end
  #
  # def apply_rule(rule)
  #   # @text.gsub!(/[^1]#{rule[0]}/, rule[1])
  #   # @text = @text.split(rule[0]).join(rule[1])
  #
  # end

  def substitute(ruleset, comp_type)
    symbol_table = Hash[ruleset]  #  { abbr: full_text, ... }

    symbol_regexp = Regexp.new("(" + symbol_table.keys.map { |k| Regexp.escape(k) }.join("|") + ")")
    @text.gsub(symbol_regexp) { |abbr| symbol_table[abbr] }.tap do |result|
      File.write('output/' + comp_type + '.txt', result)
    end
  end

  def compress
    ruleset = @symbols_ruleset + @words_ruleset

    # ruleset.each do |rule|
    #   @text.gsub!(/(?=[^1])(#{rule[0]})/,rule[1])
    # end
    # File.write('output/compressed.txt', @text)
    # @text

    substitute(ruleset, 'compressed')
  end

  def decompress
    reversed_symbols_rules = reverse_rule_order(@symbols_ruleset)
    reversed_words_rules = reverse_rule_order(@words_ruleset)
    swapped_rules = swap_rule_pairs(reversed_symbols_rules + reversed_words_rules)

    # swapped_rules :: [[abbr, full_text]]
    # symbol_table = Hash[swapped_rules]  #  { abbr: full_text, ... }
    #
    # symbol_regexp = Regexp.new("(" + symbol_table.keys.map { |k| Regexp.escape(k) }.join("|") + ")")
    # @text.gsub(symbol_regexp) { |abbr| symbol_table[abbr] }.tap do |decompressed|
    #   File.write('output/decompressed.txt', decompressed)
    # end

    substitute(swapped_rules, 'decompressed')
  end

  def swap_rule_pairs(ruleset)
    ruleset.map do |rule|
      rule.reverse
    end
  end

  def reverse_rule_order(ruleset)
    ruleset.reverse
  end
end
