class TaskView < UIView
  attr_accessor :task, :title, :done, :memo

  def initWithFrame(rect)
    super
    self.backgroundColor = '#333333'.to_color

    @title = UILabel.alloc.init.tap do |l|
      l.text = 'タスク'
      l.font = UIFont.fontWithName('HiraKakuProN-W6', size:128)
      l.backgroundColor = UIColor.clearColor
      l.textColor = UIColor.whiteColor
      l.adjustsFontSizeToFitWidth = true
    end

    addSubview(@title)

    self
  end

  def layoutSubviews
    @title.frame = [
      [30, 10],
      [frame.size.width-(30*2), frame.size.height-(10*2)]
    ]
  end
end