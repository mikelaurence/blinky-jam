require './color'
require './blinky'
require './pattern'

@blinky = ENV['TEST'] ? Blinky::Test.new : Blinky::Serial.new

cyan = Color.new(0, 1.0, 1.0)
blue = Color.new(0, 0, 1.0)
greenish = Color.new(0, 1.0, 0.2)

segment1 = Pattern::SlopeSegment.new(0..29)
color1 = Pattern::Color.new(cyan)
segment1.connect color1

segment2 = Pattern::SlopeSegment.new(30..59, true)
color2 = Pattern::Color.new(greenish)
segment2.connect color2

pattern = Pattern::Join.new(segment1, segment2)

t = Time.now
last_t = t

mod = 0.02

while true
  delta = Time.now - last_t

  if (Time.now - t) > 30.0 / Pattern.tempo
    pattern.mod 0, mod
    t = Time.now
    mod += 0.02
  end

  pattern.step delta

  @blinky.paint do |blinky|
    60.times do |c|
      if pixel = pattern.pixel(c)
        blinky.pixel pixel
      end
    end
  end

  last_t = Time.now
  sleep 0.01
end