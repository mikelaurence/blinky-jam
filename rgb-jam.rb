require './color'
require './blinky'

@blinky = Blinky.new

color = Color.new(255, 0, 0)

while true
  60.times{ @blinky.pixel color }
  @blinky.refresh

  color.r -= 1
  color.r = 255 if color.r == 0

  sleep 0.01
end