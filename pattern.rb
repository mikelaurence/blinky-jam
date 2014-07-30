class Pattern

  @tempo = 100

  def self.tempo
    @tempo
  end

  class Base

    attr_accessor :colors, :width

    def initialize(colors, width)
      @colors = [*colors]
      @width = width
    end

    def hit(power = 1.0)
    end

    def step(delta)
    end

    def tempo_delta(delta)
      Pattern.tempo / 60.0 * delta
    end

  end

  class Solid < Base

    def color(c)
      @colors[0]
    end

  end

  class SolidPump < Base

    def initialize(colors, width)
      super
      @pump = 0
    end

    def color(c)
      color = @colors[0].dup
      color.r -= @pump
      color.g -= @pump
      color.b -= @pump
      color
    end

    def hit(power = 1.0)
      @pump = 0
    end

    def step(delta)
      @pump += tempo_delta(delta)
    end

  end


end