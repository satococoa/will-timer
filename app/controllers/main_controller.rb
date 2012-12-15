class MainController < UIViewController
  def loadView
    self.view = UIView.new.tap do |v|
      v.backgroundColor = UIColor.underPageBackgroundColor
    end
  end

  def viewDidLoad
    super
  end
end