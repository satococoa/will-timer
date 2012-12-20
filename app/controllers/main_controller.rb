class MainController < UIViewController
  include BW::KVO
  attr_accessor :working

  def dealloc
    App.notification_center.unobserve(@style_observer)
    unobserve_all
  end

  def initWithNibName(nibNameOrNil, bundle:nibBundleOrNil)
    super
    @working = false
    @remaining = 25 * 60
    self.title = 'WillTimer'
    observe(self, :working) do |old_value, new_value|
    end
    self
  end

  def loadView
    self.view = UIView.alloc.init.tap do |v|
      v.backgroundColor = UIColor.underPageBackgroundColor
    end

    @tasks = UIBarButtonItem.alloc.initWithTitle(t(:tasks, 'Tasks'), style:UIBarButtonItemStyleBordered, target:self, action:'open_tasks')
    @settings = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed('gear.png'), style:UIBarButtonItemStylePlain, target:self, action:'open_settings')
    navigationItem.leftBarButtonItem = @tasks
    navigationItem.rightBarButtonItem = @settings

    @task = UILabel.alloc.init.tap do |l|
      l.text = 'タスクその1'
      l.font = UIFont.fontWithName('HiraKakuProN-W6', size:128)
      l.frame = [[40, 100], [1024-80, 200]]
      l.backgroundColor = UIColor.clearColor
      l.textColor = UIColor.blackColor
      l.adjustsFontSizeToFitWidth = true
      l.layer.borderColor = '#cccccc'.to_color
      l.layer.borderWidth = 3
    end

    @left_time = UILabel.alloc.init.tap do |l|
      l.text = "10'25\""
      l.font = UIFont.fontWithName('Verdana-BoldItalic', size:128)
      l.frame = [[40, 424], [512, 250]]
      l.backgroundColor = UIColor.clearColor
    end

    @pause_restart_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.setTitle('一時停止', forState:UIControlStateNormal)
      b.addTarget(self, action:'pause_or_restart', forControlEvents:UIControlEventTouchUpInside)
      b.frame = [[552+50, 424+75], [100, 100]]
    end

    @interrupt_button = UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.setTitle('中止', forState:UIControlStateNormal)
      b.addTarget(self, action:'interrupt', forControlEvents:UIControlEventTouchUpInside)
      b.frame = [[552+50+100+50, 424+75], [100, 100]]
    end

    self.view.addSubview(@task)
    self.view.addSubview(@left_time)
    self.view.addSubview(@pause_restart_button)
    self.view.addSubview(@interrupt_button)
  end

  def open_tasks
    p 'open_tasks'
  end

  def open_settings
    p 'open_settings'
  end

  def pause_or_restart
    p 'pause_or_restart'
    self.working != @working
  end

  def interrupt
    p 'interrupt'
    self.working = false
  end
end