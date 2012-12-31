Teacup::Stylesheet.new(:main_view) do
  style :root,
    landscape: true,
    portrait: false,
    backgroundColor: UIColor.underPageBackgroundColor
end

class MainController < UIViewController
  include BW::KVO
  attr_accessor :working

  stylesheet :main_view

  layout :root do
    # FIXME: viewのサイズもStyleSheetでやりたい
    @timer_view = subview(
      TimerView.alloc.initWithFrame([[0, 0], [1028, 460]])
    )
    @task_view = subview(
      TaskView.alloc.initWithFrame([[0, 460], [1028, 308]])
    )
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

  def dealloc
    unobserve_all
  end

  def viewDidLoad
    super
    @tasks = UIBarButtonItem.alloc.initWithTitle(t(:tasks, 'Tasks'), style:UIBarButtonItemStyleBordered, target:self, action:'open_tasks')
    @settings = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed('gear.png'), style:UIBarButtonItemStylePlain, target:self, action:'open_settings')
    navigationItem.leftBarButtonItem = @tasks
    navigationItem.rightBarButtonItem = @settings
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