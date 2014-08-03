require 'serialport'
require 'paint'

module Blinky

  class Serial

    def initialize(port = '/dev/tty.usbmodemfa141')
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

    def paint(&block)
      yield self
      refresh
    end

  end

  class Test

    def pixel(color)
      print Paint['█', [color.r_rgb, color.g_rgb, color.b_rgb]]
    end

    def refresh
    end

    def close
    end

    def paint(&block)
      print "\b" * 60
      yield self
    end

  end

end