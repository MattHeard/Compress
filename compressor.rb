require_relative 'ruleset'

class Compressor
  def initialize(text)
    @text = text
    @ruleset = RULESET
  end

  def substitute(ruleset)
    ruleset.each do |rule|
      apply_rule(rule)
    end
    @text
  end

  def apply_rule(rule)
    @text.gsub!(/#{rule[0]}/, rule[1])
  end

  def compress
    compressed = substitute(@ruleset)
    File.write('output/compressed.txt', compressed)
    compressed
  end

  def decompress
    swapped_rules = swap_rule_pairs(@ruleset)
    new_rules = reverse_rule_order(swapped_rules)

    decompressed = substitute(new_rules)
    File.write('output/decompressed.txt', decompressed)
    decompressed
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
