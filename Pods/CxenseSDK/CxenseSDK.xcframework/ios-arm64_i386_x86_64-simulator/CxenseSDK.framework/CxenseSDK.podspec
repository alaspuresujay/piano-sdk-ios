Pod::Spec.new do |s|
  s.name             = 'CxenseSDK'
  s.version          = '1.9.100'
  s.summary          = 'Capture all user interactions across desktop, tablet, and mobile devices. Display data in dashboards and improve the user experience.'

  s.description      = <<-DESC
Capture all user interactions across desktop, tablet, and mobile devices. Display data in intuitive dashboards and improve the user experience.
The Cxense core engine is built on our technology, optimized to capture and action a large number of events in real time.
* Get tailored traffic reports to understand how people consume content.
* Identify the external sites that drive traffic to you.
* See how traffic is split across different devices, browsers, and operating systems.
* Follow the popularity of individual articles and pages through their lifecycle and get detailed information on pageviews and unique users – and discover how the article can drive recommendations and contextual ads.
* Understand how people navigate to articles, how much time they spend there, and where they go next.
                       DESC

  s.homepage = "https://www.cxense.com"
  s.license = {
    :type => 'Copyright',
    :text => <<-LICENSE
      Copyright (c) 2016 - 2018 Cxense, Inc. All rights reserved.
      LICENSE
  }
  s.author = { 'Cxense' => 'support@cxense.com' }
  s.source = { http: "https://s3.amazonaws.com/sdk.cxense.com/CxenseSDK-iOS-1.9.100.zip", type: :zip }

  s.ios.deployment_target = '9.0'

  s.preserve_paths = 'CxenseSDK.xcframework'
  s.vendored_frameworks = 'CxenseSDK.xcframework'

  s.frameworks = 'Foundation', 'CoreData'
end
