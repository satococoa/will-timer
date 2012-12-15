# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler/setup'
Bundler.require :default

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'will-timer'
  app.device_family = [:ipad]
  app.interface_orientations = [:landscape_left, :landscape_right]

  conf_file = './config.yml'
  if File.exists?(conf_file)
    config = YAML::load_file(conf_file)
    app.testflight.sdk        = 'vendor/TestFlightSDK1.1'
    app.testflight.api_token  = config['testflight']['api_token']
    app.testflight.team_token = config['testflight']['team_token']
    app.testflight.notify     = true
    app.testflight.distribution_lists = config['testflight']['distribution_lists']
    app.identifier = config['identifier']
    app.info_plist['CFBundleURLTypes'] = [
      { 'CFBundleURLName' => config['identifier'],
        'CFBundleURLSchemes' => ['will-timer'] }
    ]
    env = ENV['ENV'] || 'development'
    app.codesign_certificate = config[env]['certificate']
    app.provisioning_profile = config[env]['provisioning']
  end

  app.pods do
    pod 'Nimbus'
  end
end
