require "mobile_subscriber/version"
require 'active_support/all'

module MobileSubscriber
  extend ActiveSupport::Autoload

  autoload :ISDN, "mobile_subscriber/isdn.rb"

  module Detection
    extend ActiveSupport::Autoload
    autoload :FromMsisdnHttpRequestHeader
    autoload :FromXNokiaMsisdnHttpRequestHeader
    autoload :FromXUpCallingLineIdHttpRequestHeader
    autoload :FromXUpChMsisdnHttpRequestHeader
    autoload :FromXUpSubnoHttpRequestHeader
    autoload :FromXWapSesiones3gMdnHttpRequestHeader
    autoload :HttpRequestInfo
  end
end
