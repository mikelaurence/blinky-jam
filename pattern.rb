class Pattern

  @tempo = 100

  def self.tempo
    @tempo
  end

  class Base

    attr_accessor :child, :mod

    def pixel(i)
      child_pixel i
    end

    def child_pixel(i)
      child ? child.pixel(i) : nil
    end

    def step(delta)
    end

    def mod(type, amount = nil)
      @mod ||= {}
      @mod[type] = amount if amount
      child.mod type, amount if child && amount
      @mod[type]
    end

    def connect(*children)
      parent = self
      children.each do |c|
        parent.child = c
        parent = c
      end
    end

  end

  class Color < Base

    attr_accessor :color

    def initialize(color)
      @color = color
    end

    def pixel(i)
      @color
    end

  end

  class Segment < Base

    attr_accessor :range

    def initialize(range)
      @range = range
    end

    def pixel(i)
      range.include?(i) ? child_pixel(i) : nil
    end

  end


  class SlopeSegment < Segment

    attr_accessor :reversed

    def initialize(range, reversed = false)
      @range = range
      @reversed = reversed
    end

    def pixel(i)
      if pix = super
        pix.a = (i - range.min).to_f / (range.max - range.min)
        pix.a = 1.0 - pix.a if @reversed
        pix
      end
    end

  end

  class Join < Base

    attr_accessor :patterns

    def initialize(*patterns)
      @patterns = patterns
    end

    def pixel(i)
      @patterns.each do |pattern|
        if pix = pattern.pixel(i)
          return pix
        end
      end
    end

    def mod(type, amount = nil)
      if amount
        @patterns.each do |pattern|
          pattern.mod type, amount
        end
      end
    end

  end

  # class Base

  #   attr_accessor :colors, :width

  #   def initialize(colors, width)
  #     @colors = [*colors]
  #     @width = width
  #   end

  #   def hit(power = 1.0)
  #   end

  #   def step(delta)
  #   end

  #   def tempo_delta(delta)
  #     delta / (30.0 / Pattern.tempo)
  #   end

  # end

  # class Solid < Base

  #   def color(c)
  #     @colors[0]
  #   end

  # end

  # class SolidPump < Base

  #   def initialize(colors, width)
  #     super
  #     @index = 0
  #     @pump = 0
  #   end

  #   def color(c)
  #     color = @colors[@index].dup
  #     color.r -= @pump
  #     color.g -= @pump
  #     color.b -= @pump
  #     color
  #   end

  #   def hit(power = 1.0)
  #     @pump = 0
  #     @index += 1
  #     @index = 0 if @index >= @colors.size
  #   end

  #   def step(delta)
  #     @pump += tempo_delta(delta)
  #   end

  # end


end