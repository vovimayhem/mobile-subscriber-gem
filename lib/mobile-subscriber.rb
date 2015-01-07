require "mobile_subscriber/version"
require 'active_support/all'

module MobileSubscriber
  extend ActiveSupport::Autoload

  autoload :ISDN, "mobile_subscriber/isdn.rb"

  module Detection
    extend ActiveSupport::Autoload
    autoload :FromMsisdnHeader
    autoload :FromXNokiaMsisdnHeader
    autoload :FromXUpChMsisdnHeader
  end
end
