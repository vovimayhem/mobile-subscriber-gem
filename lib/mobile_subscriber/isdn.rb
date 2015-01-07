require 'mobile_subscriber/dictionaries/mobile_and_iso_country_codes'
require 'mobile_subscriber/dictionaries/operator_data'

module MobileSubscriber

  class ISDN

    attr_reader :id, :mobile_country_code, :mobile_network_code
    alias_method :to_s, :id

    include MobileSubscriber::Detection::FromMsisdnHeader
    include MobileSubscriber::Detection::FromXNokiaMsisdnHeader
    include MobileSubscriber::Detection::FromXUpChMsisdnHeader

    def initialize(attributes={})
      @id                   = attributes.delete :id
      @mobile_country_code  = attributes.delete :mobile_country_code
      @mobile_network_code  = attributes.delete :mobile_network_code
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
      "<MobileSubscriber::ISDN #{self.id} (#{self.http_validated? ? '' : 'not '}validated by HTTP)>"
    end

    def http_validated?
      @http_validated ||= false
    end

    # Creates a new MobileSubscriber::ISDN from a Rack::Request object
    def self.new_from_request(request)
      detected_attributes = self.methods.select do |x|
        x.to_s =~ /\Aextract_from_(\w+)_http_request_header\z/i
      end.reduce(nil) do |attrs, detection_method|
        attrs = self.send detection_method, request unless attrs.present?
        attrs
      end

      if detected_attributes.present?
        validated_isdn = new(detected_attributes)
        validated_isdn.send :http_validated!
        validated_isdn
      end
    end

    protected

      def http_validated!
        @http_validated = true
      end

  end

end
