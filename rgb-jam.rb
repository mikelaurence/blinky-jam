require './color'
require './blinky'
require './pattern'

@blinky = Blinky.new

color = Color.new(0, 1.0, 1.0)
pattern = Pattern::SolidPump.new(color, 60)

t = Time.now

while true
  if (Time.now - t) > Pattern.tempo / 60.0
    pattern.hit
    t = Time.now
  end

  pattern.step 0.01
  pattern.width.times do |c|
    if color = pattern.color(c)
      @blinky.pixel color
    end
  end
  @blinky.refresh

  sleep 0.01
end