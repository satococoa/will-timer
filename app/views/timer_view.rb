class TimerView < UIView
  include BW::KVO

  attr_accessor :remains, :digits, :start_button, :pause_button, :interrupt_button

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
          title: '開始',
          frame: [
            [frame_width-30-100, 100],
            [80, 100]
          ]
        )

        @pause_button = subview(
          UIButton.buttonWithType(UIButtonTypeRoundedRect),
          title: '一時停止',
          hidden: true,
          frame: [
            [frame_width-30-100, 100],
            [80, 100]
          ]
        )

        @interrupt_button = subview(
          UIButton.buttonWithType(UIButtonTypeRoundedRect),
          title: '中止',
          frame: [
            [frame_width-30-100, 100 + 130],
            [80, 100]
          ]
        )
      }

      observe(self, :remains) do |old_value, new_value|
        minutes = new_value / 60
        seconds = new_value % 60
        @digits.text = "%02d:%02d" % minutes, seconds
      end
    end
  end

  def dealloc
    unobserve_all
  end
end