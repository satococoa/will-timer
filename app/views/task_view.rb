class TaskView < UIView
  attr_accessor :task, :title, :done, :memo

  def initWithFrame(rect)
    super.tap do
      frame_width = CGRectGetWidth(rect)
      frame_height = CGRectGetHeight(rect)
      bgcolor = UIColor.colorWithPatternImage(UIImage.imageNamed('blackorchid.png'))

      layout(self, backgroundColor: bgcolor) {
        @title = subview(UILabel,
          frame: [
            [100, 10],
            [frame_width-(30*2)-70, frame_height-(10*2)]
            ],
          text: 'タスク',
          font: UIFont.fontWithName('HiraKakuProN-W6', size:128),
          backgroundColor: UIColor.clearColor,
          textColor: UIColor.whiteColor,
          adjustsFontSizeToFitWidth: true
        )
      }
    end
  end
end