# This is an example of a script that a user would 
#   write to solve the lawn-mowing problem.
# Written in ruby.
# It outputs a random direction each time
#   and waits for input.

@inputted

def output! text
  file = File.open("to_game.txt", "a")
  file.print text if !text.nil?
  file.close
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

def wait_for_ack
  while (inn = input!.length) <= @inputted.length 
  end
  puts "ACK!" if (inn <=> "ack") == 0
  puts "bad" if (inn <=> "bad") == 0
  go_at_random
  @inputted = input!
end

def go_at_random
  r = (rand*4).floor
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

if __FILE__ == $0
  #get initial data:
  @inputted = input!
  
  go_at_random
  while (@inputted[-1] <=> "victory!") != 0
    wait_for_ack
  end
  
  puts "WE WIN!!!!"
end


















