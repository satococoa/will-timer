class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    main_controller = MainController.new
    @window = UIWindow.alloc.initWithFrame(App.bounds)
    @window.rootViewController = main_controller
    @window.makeKeyAndVisible
    true
  end
end
