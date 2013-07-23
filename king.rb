class King < Stepper
  def initialize(color)
    super(color)
  end

  def to_s
    "K".colorize(@color)
  end
end