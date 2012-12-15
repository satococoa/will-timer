module Kernel
  def t(label, fallback)
    BubbleWrap.localized_string(label, fallback)
  end
end