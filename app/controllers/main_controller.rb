Teacup::Stylesheet.new(:main_view) do
  style :root,
    landscape: true,
    portrait: false,
    backgroundColor: UIColor.underPageBackgroundColor
end

class MainController < UIViewController
  include BW::KVO
  attr_accessor :remaining
  DEFAULT_REMAINING = 25 * 60

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
    self.remaining = DEFAULT_REMAINING
    self.title = 'WillTimer'
    @interrupt_alert = UIAlertView.alloc.initWithTitle(
      t(:interrupt, 'Interrupt'),
      message:t(:interrupt_sure, 'Are you sure to interrupt?'),
      delegate:self,
      cancelButtonTitle:t(:cancel, 'Cancel'),
      otherButtonTitles:t(:ok, 'OK'), nil).tap do |al|
      al.tag = 1
    end
    @timeup_alert = UIAlertView.alloc.initWithTitle(
      t(:timeup, 'Timeup!'),
      message:t(:timeup_message, "It's time to rest."),
      delegate:self,
      cancelButtonTitle:t(:ok, 'OK'),
      otherButtonTitles:nil).tap do |al|
      al.tag = 2
    end
    self
  end

  def viewDidLoad
    super
    @tasks = UIBarButtonItem.alloc.initWithTitle(t(:tasks, 'Tasks'), style:UIBarButtonItemStyleBordered, target:self, action:'open_tasks')
    @settings = UIBarButtonItem.alloc.initWithImage(UIImage.imageNamed('gear.png'), style:UIBarButtonItemStylePlain, target:self, action:'open_settings')
    navigationItem.leftBarButtonItem = @tasks
    navigationItem.rightBarButtonItem = @settings
    @timer_view.remains = self.remaining

    @timer_view.start_button.when_tapped do
      @timer_view.working = true
      @timer = EM.add_periodic_timer 1.0 do
        self.remaining -= 1.0
        if self.remaining <= 0
          EM.cancel_timer(@timer)
          alerm
        end
      end
    end
    @timer_view.pause_button.when_tapped do
      @timer_view.working = false
      EM.cancel_timer(@timer)
    end
    @timer_view.interrupt_button.when_tapped do
      @interrupt_alert.show
    end
    @timer_view.reset_button.when_tapped do
      self.remaining = DEFAULT_REMAINING
    end
  end

  def viewWillAppear(animated)
    observe(self, :remaining) do |old_value, new_value|
      @timer_view.remains = new_value
    end
    observe(@timer_view, :working) do |old_value, new_value|
      puts "\e[32mworking changed: #{old_value} -> #{new_value}\e[0m"
    end
  end

  def viewWillDisappear(animated)
    unobserve_all
  end

  def open_tasks
    p 'open_tasks'
  end

  def open_settings
    p 'open_settings'
  end

  def alertView(alert_view, clickedButtonAtIndex:button_index)
    case alert_view.tag
    when 1
      if button_index != alert_view.cancelButtonIndex
        @timer_view.working = false
        EM.cancel_timer(@timer)
        self.remaining = DEFAULT_REMAINING
      end
    when 2
      self.remaining = DEFAULT_REMAINING
    end
  end

  def alerm
    AudioServicesPlaySystemSound(1005)
    @timer_view.working = false
    @timeup_alert.show
  end
end