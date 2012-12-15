class AppDelegate
  attr_accessor :stylesheet_cache

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(App.bounds)

    path_prefix = NIPathForBundleResource(nil, 'css')
    host = 'http://localhost:8888/'
    @stylesheet_cache = NIStylesheetCache.alloc.initWithPathPrefix(path_prefix)
    @chameleonObserver = NIChameleonObserver.alloc.initWithStylesheetCache(
      @stylesheet_cache, host:host)
    @chameleonObserver.watchSkinChanges

    main_controller = MainController.alloc.initWithNibName(nil, bundle:nil)
    @root_controller = UINavigationController.alloc.initWithRootViewController(main_controller)
    @window.rootViewController = @root_controller

    @window.makeKeyAndVisible

    true
  end
end
