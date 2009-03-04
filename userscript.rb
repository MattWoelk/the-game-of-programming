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
  puts "iterating."
  @x = @xp
  @y = @yp
end

def wait_for_ack
  while (inn = input!).length <= @inputted.length
  end
  puts "#{@x},#{@y}"
  iterate if (inn[-1].strip <=> "bad") != 0
  
  puts "ACK!" if (inn[-1].strip <=> "ack") == 0
  puts "bad" if (inn[-1].strip <=> "bad") == 0
  go_to_grass @x, @y
  @inputted = input!
end

def tall_grass? x, y
  puts "tall grass at #{x}, #{y}?"
  puts "in: #{in?(x, y)}"
  in?(x, y) && (@data[x][y] <=> 'W') == 0
end

def in? x, y
  puts "@data.length: #{@data.length}"
  puts "@data[0].length: #{@data[0].length}"
  x >= 0 && y >= 0 && x < @data.length && y < @data[0].length
end

def go_to_grass x, y
  puts "trying to go to grass"
  if tall_grass? x-1, y
    @xp = x-1
    puts "w"
    output! "\nw"
  elsif tall_grass? x, y-1
    @yp = y-1
    puts "n"
    output! "\nn"
  elsif tall_grass? x+1, y
    @xp = x+1
    puts "e"
    output! "\ne"
  elsif tall_grass? x, y+1
    @yp = y+1
    puts "s"
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
  
  @data = @inputted.map{|e| e.strip.split}
  @new = []
  c = 0
  while @data[c] != [] && !@data[c].nil?
    @new << @data[c]
    c += 1
  end
  @data = @new
  #this is now a 2D array of our data.
  p @data
  
  #go_at_random
  @inputted = @inputted[0]
  #p @inputted
  #p @inputted.length
  while (@inputted[-1] <=> "victory!") != 0
    wait_for_ack
  end
  puts "WE WIN!!!!"
end


















