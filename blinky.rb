require 'serialport'

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