## sourceを処理する
def preprocess(source)
  result = []
  source = source.split("\n") # 行毎に分割
  
  result_source_code = []
  program_source = []
  
  here = false

  source.each do |line|
    runner = ''
    show = true
    hereend = false
    if line.include?('//%')
      idx = line.index('//%')
      runner = line[(idx+3)...line.length]
      line = line[0...idx]
      if line.strip == ""
        show = false
      end
      hereend = true
    end
   
    if hereend && here
      result <<= 'P'
      here = false
    end
    if here
      result <<= line
      next
    end
    if show
      program_source <<= line
      result <<= "result_source_code <<= program_source[#{program_source.size - 1}].gsub" + '(/\/\*%(.+)\*\//) {|a| eval $1}'
    end
    if runner.strip != ''
      # プログラムを実行
      if runner.start_with?('=')
        runner[0...1] = 'result_source_code <<= '
      end
      result <<= runner
      if runner.include?('<<P')
        here = true    
      end
    end
  end
  eval result.join("\n")
  return result_source_code.join("\n")
end

def process_comment(str)
  return str.gsub(r) do |match|
    eval($1)
  end
end
