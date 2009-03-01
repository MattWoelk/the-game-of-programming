#THIS DOES NOT WORK YET.

@inputted
@x
@y
@xp
@yp

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
  go_to_grass @x, @y
  @inputted = input!
end

def tall_grass? x, y
  return true if in?(x, y) && (@data[x][y] <=> 'W') == 0
  false
end

def in? x, y
  return true if x >= 0 && y >= 0 && x < @data.length && y < @data[0].length
end

def go_to_grass x, y
  if tall_grass? x-1, y
    @xp = x-1
    output! "\nw"
  elsif tall_grass? x, y-1
    @yp = y-1
    output! "\nn"
  elsif tall_grass? x+1, y
    @xp = x+1
    output! "\ne"
  elsif tall_grass? x, y+1
    @yp = y+1
    output! "\ns"
  else
    go_at_random
  end
end

def go_at_random
  r = (rand*4).floor
  #puts r
  case r
  when 0
    @yp = @y-1
    output! "\nn"
  when 1
    @yp = @y+1
    output! "\ns"
  when 2
    @xp = @x+1
    output! "\ne"
  when 3
    @xp = @x-1
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
  count = 0
  @inputted = input!
  @x = 0
  @y = 0
  @xp = 0
  @yp = 0
  
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


















