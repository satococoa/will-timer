class AppDelegate
  attr_accessor :stylesheet_cache

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(App.bounds)

    main_controller = MainController.alloc.initWithNibName(nil, bundle:nil)
    @root_controller = UINavigationController.alloc.initWithRootViewController(main_controller)
    @window.rootViewController = @root_controller

    @window.makeKeyAndVisible

    true
  end
end
