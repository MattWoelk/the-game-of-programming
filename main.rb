#this is the game of programming!
#objectives of the game:
# => do tasks (level 1: law-mowing) by coding algorithms.

# NEW FEATURES UNDER DEVELOPMENT:
# counter (color change?) error
# better victory panel..(show the lawn still)

begin
require 'rubygems'
rescue LoadError; end

require 'ruby-processing'
load 'lawn.rb'
load 'text.rb'
load 'iointerface.rb'

class Animator < Processing::App

def setup
  smooth
  puts "\n\nSTART_OF_PROGRUM\n--------------------"
  @size = 15
  @offset = 30
  @lawn = Lawn.new @size, @offset
  @text = TextIn.new 10, 220, self
  @io = IoInterface.new @lawn
  @io.clearfiles
  ellipse_mode CORNER
  background 200
  
  @font = $app.create_font("Univers45.vlw", 66)
  text_font(@font, 14)
  
  @lawn.filllawn(10,12) ############################
  fill(120,120,120)
  @lawn.textlawn
  
  @io.output! @lawn.text
  @lawn.cut
end

def draw
  background 120
  text("\"to_script.txt\" is what you should read.\n\"to_game.txt\" is what you should write to.\n\nn,s,e,w: commands to move lawnmower.",190,20,160,200) if !@lawn.victory
  text("VICTORY! YES!",190,20,160,200) if @lawn.victory
  text("#{@lawn.back_overs}",0,0,20,20)
  fill 200
  @lawn.printlawn
  @text.drawtext
  
  @io.input! if !@lawn.victory
  @lawn.text_input @io.read_data if @lawn.ready_to_step?
  @io.output! @lawn.text_output
end

def key_pressed
  @lawn.key_pressed key
  @text.key_pressed key
end

def mouse_pressed
  @lawn.mouse_pressed(mouse_x, mouse_y)
end

def mouse_released
  @lawn.mouse_released(mouse_x, mouse_y)
end

def run te
  eval te
  rescue SyntaxError
    puts "SyntaxError *shrug*"
  rescue NameError
    puts "NameError *shrug*"
  rescue NoMethodError
    puts "NoMethodError *shrug*"
  rescue Exception
    puts "you made an error"
end

end

Animator.new :title => "The Game of Programming", :width => 350, :height => 350