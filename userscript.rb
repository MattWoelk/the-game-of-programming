def output! text
  file = File.open("to_game.txt", "a")
  file.print text + "\n"
  file.close #do this only once?
end

def input!
  data = []
  file = File.open("to_script.txt", "r")
  while content = file.gets
    data << content
  end
  file.close
  data
end

if __FILE__ == $0
  #get initial data:
  count = 0
  inputted = input!
  @data = Array.new(inputted.size)
  @data.each {|b| b = Array.new(inputted[0].size)}
  inputted.each_index do |y|
    count = 0
    inputted[0].each_char do |x|
      puts "#{count}, #{y}"
      #@data[count][y] = x
      count += 1
    end
  end
  
  @data.each do |x|
    @data[x].each do |y|
      puts "#{x}, #{y}: #{@data[x][y]}"
    end
  end
end