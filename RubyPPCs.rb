require 'find'
puts ARGV[0]
if ARGV[0]
  Dir.chdir(ARGV[0])
end

dirs = []
runner = 'ruby '+ File.expand_path(File.dirname(__FILE__)) + "/RubyPP.rb"
Find.find(File.expand_path('.')) do |path|
  next unless File.directory?(path)
  dirs <<= path
end
dirs.each do |dir|
  Dir.chdir(dir)
  Dir.glob("*_.cs") do |f|
    `#{runner} #{f} #{f.gsub("_.cs",".cs")}`
    if $?.exitstatus != 0
      raise "Error"
    end
  end
end
