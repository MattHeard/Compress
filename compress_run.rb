require_relative 'compressor'

compressed = Compressor.new('And then it happened; I think it\'s over now.').compress

Compressor.new(compressed).decompress
