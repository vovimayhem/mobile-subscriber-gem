require "mobile_subscriber/version"
require 'active_support/all'

module MobileSubscriber
  extend ActiveSupport::Autoload
  include ActiveSupport::Configurable # add an attr_reader :config, and init as Hash

  autoload :ISDN, "mobile_subscriber/isdn"

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

  def self.configure
    yield config
  end

  # By default, disable_ip_check is false, unless the environment variable
  # 'MOBILE_SUBSCRIBER_DISABLE_IP_CHECK' is set explicitly to 'true' or 'TRUE'
  config.disable_ip_check = ENV['MOBILE_SUBSCRIBER_DISABLE_IP_CHECK'].to_s.downcase == 'true'

  # The allowed incoming proxy list between the Mobile Network APN and the
  # request processing server - that is usually reported within the 'Via' headers.
  #
  # By default, it forces the request to have no proxies between the Mobile
  # Network APN and the request processing server - Configure this accordingly
  # to include CDN's, Nginx proxies, etc.
  config.allowed_incoming_proxy_routes = []

end
