class Pattern

  NORMAL = 1
  MIRROR = 2
  INVERSE = 3
  INVERSE_MIRROR = 4

  @tempo = 100

  def self.tempo
    @tempo
  end

  def self.beat
    60.0 / Pattern.tempo
  end

  class Base

    attr_accessor :child, :mod

    def pixel(i)
      nil
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
      @mod[type] || 0
    end

    def connect(*children)
      parent = self
      children.each do |c|
        parent.child = c
        parent = c
      end
      self
    end

  end

  class Color < Base

    attr_accessor :color

    def initialize(color)
      @color = color
    end

    def pixel(i)
      @color.dup
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

    attr_accessor :type

    def initialize(range, type = Pattern::NORMAL)
      @range = range
      @type = type
    end

    def pixel(i)
      if pix = super
        i = range.max - (i - range.min) if type == Pattern::MIRROR || type == Pattern::INVERSE_MIRROR
        blank = (i - range.min) / (range.max - range.min).to_f > mod(0)
        blank = !blank if type == Pattern::INVERSE || type == Pattern::INVERSE_MIRROR
        pix.a *= 0 if blank
        pix
      end
    end

  end

  class Fade < Base

    def mod(type, amount = nil)
      @modded_at = Time.now
      super
    end

    def pixel(i)
      if pix = child_pixel(i)
        if @modded_at
          time = Time.now - @modded_at
          lerp = 1.0 - (time / Pattern.beat)
          pix.a *= lerp
        end
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

end