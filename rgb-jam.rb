require './color'
require './blinky'
require './pattern'

@blinky = Blinky.new

cyan = Color.new(0, 1.0, 1.0)
red = Color.new(1.0, 0, 0)
pattern = Pattern::SolidPump.new([cyan, red], 60)

t = Time.now
last_t = t

while true
  delta = Time.now - last_t

  if (Time.now - t) > 30.0 / Pattern.tempo
    pattern.hit
    t = Time.now
  end

  pattern.step delta
  pattern.width.times do |c|
    if color = pattern.color(c)
      @blinky.pixel color
    end
  end
  @blinky.refresh

  last_t = Time.now
  sleep 0.01
end