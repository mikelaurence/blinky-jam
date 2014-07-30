class Color

  attr_reader :r, :g, :b

  def initialize(_r, _g, _b)
    self.r = _r
    self.g = _g
    self.b = _b
  end

  def r=(val = 0)
    @data = nil
    @r = val < 0 ? 0 : val > 254 ? 254 : val
  end

  def g=(val = 0)
    @data = nil
    @g = val < 0 ? 0 : val > 254 ? 254 : val
  end

  def b=(val = 0)
    @data = nil
    @b = val < 0 ? 0 : val > 254 ? 254 : val
  end

  def data
    @data ||= "#{r.chr}#{g.chr}#{b.chr}"
  end

end