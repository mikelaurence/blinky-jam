require './color'
require './blinky'
require './patterns'

@blinky = Blinky.new

color = Color.new(1.0, 0, 0)
pattern = Pattern::Solid.new(color, 0.5)

while true
  pattern.hit
  pattern.width.times{ |c| @blinky.pixel pattern.color(c) }
  @blinky.refresh

  color.r -= 1
  color.r = 255 if color.r == 0

  sleep 0.01
end