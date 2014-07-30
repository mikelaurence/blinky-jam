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
      delta / (30.0 / Pattern.tempo)
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
      @index = 0
      @pump = 0
    end

    def color(c)
      color = @colors[@index].dup
      color.r -= @pump
      color.g -= @pump
      color.b -= @pump
      color
    end

    def hit(power = 1.0)
      @pump = 0
      @index += 1
      @index = 0 if @index >= @colors.size
    end

    def step(delta)
      @pump += tempo_delta(delta)
    end

  end


end