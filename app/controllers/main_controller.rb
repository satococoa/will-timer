class MainController < UIViewController
  include BW::KVO
  attr_accessor :working

  def dealloc
    App.notification_center.unobserve(@style_observer)
    unobserve_all
  end

  def initWithNibName(nibNameOrNil, bundle:nibBundleOrNil)
    super
    stylesheet_cache = App.delegate.stylesheet_cache
    stylesheet = stylesheet_cache.stylesheetWithPath('main.css')
    @dom = NIDOM.alloc.initWithStylesheet(stylesheet)
    @style_observer = App.notification_center.observe(NIStylesheetDidChangeNotification, stylesheet) do |notif|
      @dom.refresh
    end
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
      l.text = 'UI設計'
      l.frame = [[40, 100], [(1024-100)/2, 200]]
    end
    @dom.registerView(@task, withCSSClass:'task')

    @left_time = UILabel.alloc.init.tap do |l|
      l.text = "10'25\""
      l.frame = [[40, 424], [512, 250]]
    end
    @dom.registerView(@left_time, withCSSClass:'lefttime')

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

  def viewDidUnLoad
    @dom.unregisterAllViews
    @label = nil
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