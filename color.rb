class Color

  attr_reader :r, :g, :b

  def initialize(_r, _g, _b)
    self.r = _r
    self.g = _g
    self.b = _b
  end

  def r=(val = 0)
    @data = nil
    @r = val < 0 ? 0 : val > 1.0 ? 1.0 : val
  end

  def g=(val = 0)
    @data = nil
    @g = val < 0 ? 0 : val > 1.0 ? 1.0 : val
  end

  def b=(val = 0)
    @data = nil
    @b = val < 0 ? 0 : val > 1.0 ? 1.0 : val
  end

  def r_byte
    (@r * 254).to_i.chr
  end

  def g_byte
    (@g * 254).to_i.chr
  end

  def b_byte
    (@b * 254).to_i.chr
  end

  def data
    @data ||= "#{r_byte}#{g_byte}#{b_byte}"
  end

  def dup
    self.class.new @r, @g, @b
  end

end