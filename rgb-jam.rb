require 'BlinkyTape'

class Color

  attr_reader :r, :g, :b

  def initialize(_r, _g, _b)
    self.r = _r
    self.g = _g
    self.b = _b
  end

  def r=(val = 0)
    @data = nil
    @r = val < 0 ? 0 : val > 254 ? 254 : val
  end

  def g=(val = 0)
    @data = nil
    @g = val < 0 ? 0 : val > 254 ? 254 : val
  end

  def b=(val = 0)
    @data = nil
    @b = val < 0 ? 0 : val > 254 ? 254 : val
  end

  def data
    @data ||= "#{r.chr}#{g.chr}#{b.chr}"
  end

end

class Blinky

  def initialize(port = '/dev/tty.usbmodemfd131')
    @serial = SerialPort.new(port, 115200)
    raise "Cannot connect to #{port}" if @serial.nil?

    @serial.flush
  end

  def pixel(color)
    @serial.write color.data
    sleep 0.0001
  end

  def refresh
    @serial.write 255.chr
    @serial.flush
  end

  def close
    @serial.close
  end

end

@blinky = Blinky.new

color = Color.new(255, 0, 0)

while true
  60.times{ @blinky.pixel color }
  @blinky.refresh

  color.r -= 1
  color.r = 255 if color.r == 0

  sleep 0.01
end