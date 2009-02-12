def output! text
  file = File.open("to_script.txt", "w") #make this append instead!!
  file.puts text
  file.close #then do this only once at the end of something??
end

def input!
  file = File.open("to_game.txt", "r")
  while content = file.gets
    @data << content
  end
  file.close
end

if __FILE__ == $0
  
end