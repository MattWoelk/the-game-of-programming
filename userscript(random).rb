@inputted

def output! text
  file = File.open("to_game.txt", "a")
  file.print text + "\n"
  file.close #do this only once?
end

def input!
  data = []
  file = File.open("to_script.txt", "r")
  while content = file.gets
    data << content.strip
  end
  file.close
  data
end

def iterate
  @x = @xp
  @y = @yp
end

def wait_for_ack
  while (inn = input!.length) <= @inputted.length 
  end
  puts "#{@x},#{@y}"
  iterate if (inn <=> "bad") != 0
  
  puts "ACK!" if (inn <=> "ack") != 0
  puts "bad" if (inn <=> "bad") != 0
  go_at_random
  @inputted = input!
end

def go_at_random
  r = (rand*4).floor
  #puts r
  case r
  when 0
    output! "\nn"
  when 1
    output! "\ns"
  when 2
    output! "\ne"
  when 3
    output! "\nw"
  end
end

def output! text
  file = File.open("to_game.txt", "a")
  file.print text if !text.nil?
  file.close #then do this only once at the end of something??
end

if __FILE__ == $0
  #get initial data:
  @inputted = input!
  
  @data = Array.new(@inputted.length)
  @data.length.times do |x|
    @data[x] = []
    @inputted[0].length.times do |y|
      @data[x] << @inputted[x][y,1]
    end
  end
  go_at_random
  while (@inputted[-1] <=> "victory!") != 0
    wait_for_ack
  end
  puts "WE WIN!!!!"
end


















