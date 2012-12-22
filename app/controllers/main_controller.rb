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

    @timer_view = TimerView.alloc.initWithFrame([[0, 0], [1028, 460]])
    self.view.addSubview(@timer_view)
    @task_view = TaskView.alloc.initWithFrame([[0, 460], [1028, 308]])
    self.view.addSubview(@task_view)
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