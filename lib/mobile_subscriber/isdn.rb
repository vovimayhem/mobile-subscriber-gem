require 'mobile_subscriber/dictionaries/mobile_and_iso_country_codes'
require 'mobile_subscriber/dictionaries/dialing_and_country_codes'
require 'mobile_subscriber/dictionaries/operator_data'
require 'mobile_subscriber/dictionaries/ip_ranges'
module MobileSubscriber

  class ISDN

    attr_reader :id, :mobile_country_code, :mobile_network_code, :http_request_info
    alias_method :to_s, :id

    extend MobileSubscriber::Detection::FromMsisdnHttpRequestHeader
    extend MobileSubscriber::Detection::FromXNokiaMsisdnHttpRequestHeader
    extend MobileSubscriber::Detection::FromXUpCallingLineIdHttpRequestHeader
    extend MobileSubscriber::Detection::FromXUpChMsisdnHttpRequestHeader
    extend MobileSubscriber::Detection::FromXUpSubnoHttpRequestHeader

    def initialize(attributes={})
      @id                   = attributes.delete :id
      @mobile_country_code  = attributes.delete :mobile_country_code
      @mobile_network_code  = attributes.delete :mobile_network_code
      @http_request_info    = attributes.delete :http_request_info
    end

    def dialing_code
      self.id[0,2]
    end
    alias_method :country_dialing_code, :dialing_code

    def iso_3166_country_code
      if self.mobile_country_code.present?
        MobileSubscriber::MCC_ISO_COUNTRY_CODES[self.mobile_country_code]
      end
    end

    def mobile_network_brand
      if self.mobile_country_code.present? && self.mobile_network_code.present?
        key = [self.mobile_country_code, self.mobile_network_code]
        MobileSubscriber::OPERATOR_DATA[key][:brand]
      end
    end

    def mobile_network_operator
      if self.mobile_country_code.present? && self.mobile_network_code.present?
        key = [self.mobile_country_code, self.mobile_network_code]
        MobileSubscriber::OPERATOR_DATA[key][:operator]
      end
    end

    def inspect
      "<MobileSubscriber::ISDN #{self.id} (#{self.valid? ? '' : 'not '}valid)>"
    end

    # Creates a new MobileSubscriber::ISDN from a Rack::Request object
    def self.new_from_request(request)
      http_request_info = Detection::HttpRequestInfo.new request.env

      detection_results = self.methods.select do |x|
        x.to_s =~ /\Aextract_from_(\w+)_http_request_header\z/i
      end.map do |detection_method|
        self.send detection_method, http_request_info
      end.compact

      # TODO: Select first from a preference order:
      detection = detection_results.first if detection_results.any?

      if detection.present? and (isdn = new detection).valid?
        isdn
      end
    end

    def mcc_mnc
      [self.mobile_country_code, self.mobile_network_code]
    end

    def valid?
      validation_passed = MobileSubscriber.config.disable_ip_check

      # Check IP Range:
      unless validation_passed

        # TODO: Check proxying
        user_ip_address = self.http_request_info.remote_ip

        ip_ranges = MobileSubscriber::OPERATOR_IP_RANGES[self.mcc_mnc]

        if (ip_ranges.present? && ip_ranges.count == 2 && ip_ranges.map(&:class).map(&:name).uniq == ["String"])
          ip_ranges = MobileSubscriber::OPERATOR_IP_RANGES[ip_ranges]
        end

        if ip_ranges.present?
          validations = ip_ranges.map do |ip_range|
            ip_range.include? user_ip_address
          end.uniq
          validation_passed = validations.include? true
        end
      end
      validation_passed
    end

  end

end
