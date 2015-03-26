require "mobile_subscriber/version"
require 'active_support/all'

module MobileSubscriber
  extend ActiveSupport::Autoload

  autoload :Identity

  module HTTP
    extend ActiveSupport::Autoload
    autoload :RequestInfo
  end

  module MSISDNExtraction
    extend ActiveSupport::Autoload
    autoload :FromMsisdnHttpRequestHeader
    autoload :FromXNokiaMsisdnHttpRequestHeader
    autoload :FromXUpCallingLineIdHttpRequestHeader
    autoload :FromXUpChMsisdnHttpRequestHeader
    autoload :FromXUpSubnoHttpRequestHeader
    autoload :FromXWapMsisdnHttpRequestHeader
    autoload :FromXWapSesiones3gMdnHttpRequestHeader
    autoload :FromXZtgoBeareraddressHttpRequestHeader
  end

  module IMSIExtraction
    extend ActiveSupport::Autoload
    autoload :FromXImsiHttpRequestHeader
    autoload :FromXNokiaImsiHttpRequestHeader
  end
end
