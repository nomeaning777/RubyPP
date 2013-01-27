# -*- coding:utf-8
if ARGV.size != 2
  STDERR.puts <<EOS
Ruby Preprocessor
Usage: RubyPP.bat src_file dst_file

EOS
  exit 1
end

src = ARGV[0]
dst = ARGV[1]
source = File.read(src, :encoding => Encoding::UTF_8)

require_relative 'PreProcessor.rb'
File.write(dst,preprocess(source))
