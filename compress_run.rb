require_relative 'compressor'

# compressed = Compressor.new("The quick brown fox jumps over the lazy dog").compress
compressed = Compressor.new(File.read("sample.txt")).compress

Compressor.new(compressed).decompress
