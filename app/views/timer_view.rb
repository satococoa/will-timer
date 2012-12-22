class TimerView < UIView
  include BW::KVO

  attr_accessor :remains, :digits, :start_button, :pause_button, :interrupt_button

  def initWithFrame(rect)
    super
    self.backgroundColor = '#666666'.to_color

    @digits = UILabel.alloc.init.tap do |l|
      l.text = '00:00'
      l.font = UIFont.fontWithName('HelveticaNeue-CondensedBold', size:256)
      l.textColor = UIColor.whiteColor
      l.backgroundColor = UIColor.clearColor
    end
    addSubview(@digits)

    @start_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.setTitle('開始', forState:UIControlStateNormal)
    end
    addSubview(@start_button)

    @pause_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.setTitle('一時停止', forState:UIControlStateNormal)
      b.hidden = true
    end
    addSubview(@pause_button)

    @interrupt_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.setTitle('中止', forState:UIControlStateNormal)
    end
    addSubview(@interrupt_button)

    observe(self, :remains) do |old_value, new_value|
      minutes = new_value / 60
      seconds = new_value % 60
      @digits.text = "%02d:%02d" % minutes, seconds
    end

    self
  end

  def dealloc
    unobserve_all
  end

  def layoutSubviews
    @digits.frame = [
      [30, 10],
      [frame.size.width-(30*2)-100, frame.size.height-(10*2)]
    ]
    @start_button.frame = [
      [frame.size.width-30-100, 100],
      [80, 100]
    ]
    @pause_button.frame = @start_button.frame
    @interrupt_button.frame = [
      [frame.size.width-30-100, 100 + 130],
      [80, 100]
    ]
  end
end