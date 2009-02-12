
#require 'ruby-processing'

class TextIn
  attr  :buff
  def initialize(x,y,parent)
    @parent = parent
    @xpos = x
    @ypos = y
    @buff_pos = 0
    @buff_xoff = 0
    @buff_yoff = 0
    @buff = "puts 'success!'"
    @rPos = 0
    @font = $app.create_font("Univers45.vlw", 66)
    $app.text_font(@font, 20)
  end
  
  def drawtext
    if(($app.millis() % 500) < 250)  # Only fill cursor half the time
      $app.stroke(0);
      $app.noFill();
    else 
      $app.fill(255);
      $app.stroke(0);
    end
    
    @rPos = $app.textWidth(@buff[0...(@buff.length - @buff_xoff)])
    $app.rect(@rPos + @xpos, @ypos, 10, 21)
    $app.fill(255)
    $app.text(@buff, @xpos, @ypos, $app.width - @xpos, $app.height - @ypos)
    $app.no_fill
    $app.stroke(0);
    $app.rect(@xpos, @ypos, $app.width - 2*@xpos, $app.height - @ypos - @xpos)
  end
  
  def key_pressed key
    case key
    when 5000..800000
      #this is to catch shift and arrows
    when 8
      @buff.chop!
    when 10
      #enter
      @parent.run @buff
    when 2     #these are for emacs-type movements
      @buff_xoff += 1
    when 6
      @buff_xoff -= 1
    else
      @buff << key
    end
    #puts key
  end
end