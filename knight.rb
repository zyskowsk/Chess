class Knight < Stepper
  def initialize(color)
    super(color)
  end

  def to_s
    "N".colorize(@color)
  end
end