class TimerView < UIView
  include BW::KVO

  attr_accessor :remains, :digits, :start_button, :pause_button, :interrupt_button, :working

  def initWithFrame(rect)
    super.tap do
      frame_width = CGRectGetWidth(rect)
      frame_height = CGRectGetHeight(rect)

      bgcolor = UIColor.colorWithPatternImage(UIImage.imageNamed('carbon_fibre.png'))

      layout(self, backgroundColor: bgcolor) {
        @digits = subview(NIAttributedLabel,
          text: '00:00',
          font: UIFont.fontWithName('HelveticaNeue-CondensedBold', size:256),
          textColor: '#eeeeee'.to_color,
          shadowOffset: CGSizeMake(0, 1),
          shadowColor: UIColor.whiteColor,
          shadowBlur: 0.5,
          backgroundColor: UIColor.clearColor,
          frame: [
            [100, 60],
            [frame_width-(30*2)-100-70, frame_height-60]
          ]
        )

        @start_button = subview(
          UIButton.buttonWithType(UIButtonTypeRoundedRect),
          title: t(:start, 'Start'),
          frame: [
            [frame_width-30-100, 100],
            [80, 100]
          ]
        )

        @pause_button = subview(
          UIButton.buttonWithType(UIButtonTypeRoundedRect),
          title: t(:pause, 'Pause'),
          hidden: true,
          frame: [
            [frame_width-30-100, 100],
            [80, 100]
          ]
        )

        @interrupt_button = subview(
          UIButton.buttonWithType(UIButtonTypeRoundedRect),
          title: t(:interrupt, 'Interrupt'),
          enabled: false,
          frame: [
            [frame_width-30-100, 100 + 130],
            [80, 100]
          ]
        )
      }

      self.working = false
      observe(self, :remains) do |old_value, new_value|
        minutes = new_value / 60
        seconds = new_value % 60
        @digits.text = "%02d:%02d" % [minutes, seconds]
        @digits.textKern = 24.0
        @digits.textKern = 25.0
        # @digits.setTextColor(
        #   '#333333'.to_color,
        #   range:@digits.text.rangeOfString(':'))
      end
      observe(self, :working) do |old_value, new_value|
        if new_value
          @start_button.hidden = true
          @pause_button.hidden = false
        else
          @start_button.hidden = false
          @pause_button.hidden = true
        end
      end
    end
  end

  # タイマーが進んだときのみ中断ボタンを押せるようにする
  def interruptable=(interruptable)
    if interruptable
      @interrupt_button.enabled = true
    else
      @interrupt_button.enabled = false
    end
  end

  def dealloc
    unobserve_all
  end
end