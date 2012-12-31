class TimerView < UIView
  include BW::KVO

  attr_accessor :remains, :digits, :start_button, :pause_button, :interrupt_button, :working

  def initWithFrame(rect)
    super.tap do
      frame_width = CGRectGetWidth(rect)
      frame_height = CGRectGetHeight(rect)

      layout(self, backgroundColor: '#666666'.to_color) {
        @digits = subview(UILabel,
          text: '00:00',
          font: UIFont.fontWithName('HelveticaNeue-CondensedBold', size:256),
          textColor: UIColor.whiteColor,
          backgroundColor: UIColor.clearColor,
          frame: [
            [30, 10],
            [frame_width-(30*2)-100, frame_height-(10*2)]
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