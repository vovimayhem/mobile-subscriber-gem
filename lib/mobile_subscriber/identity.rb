require 'mobile_subscriber/dictionaries/mobile_and_iso_country_codes'
require 'mobile_subscriber/dictionaries/dialing_and_country_codes'
require 'mobile_subscriber/dictionaries/operator_data'

module MobileSubscriber

  # Identity class
  class Identity

    attr_reader :mcc, :mnc, :msisdn, :imsi, :http_request_info

    alias_method :mobile_country_code, :mcc
    alias_method :mobile_network_code, :mnc
    alias_method :international_mobile_subscriber_identity, :imsi
    alias_method :mobile_station_international_subscriber_directory_number, :msisdn

    def initialize(attributes={})
      @msisdn = attributes.delete :msisdn
      @imsi   = attributes.delete :imsi
      @mcc    = attributes.delete :mcc
      @mnc    = attributes.delete :mnc
      @http_request_info    = attributes.delete :http_request_info
    end

    def id
      if imsi.present?
        "imsi:#{imsi}"
      else
        "msisdn:#{msisdn}"
      end
    end
    alias_method :to_s, :id

    def dialing_code
      MobileSubscriber::DIALING_COUNTRY_CODES[iso_3166_country_code] if mcc.present?
    end
    alias_method :country_dialing_code, :dialing_code

    def iso_3166_country_code
      MobileSubscriber::MCC_ISO_COUNTRY_CODES[mcc] if mcc.present?
    end

    def mobile_network_brand
      MobileSubscriber::OPERATOR_DATA[[mcc, mnc]][:brand] if mcc.present? && mnc.present?
    end

    def mobile_network_operator
      MobileSubscriber::OPERATOR_DATA[[mcc, mnc]][:operator] if mcc.present? && mnc.present?
    end

    def inspect
      "<MobileSubscriber::Identity #{self.id} (#{self.http_validated? ? '' : 'not '}validated by HTTP)>"
    end

    def http_validated?
      @http_validated ||= false
    end

    # Creates a new MobileSubscriber::ISDN from a Rack::Request object
    def self.new_from_request(request)
      http_request_info = MobileSubscriber::HTTP::RequestInfo.new request.env

      # TODO: Validate request for forged data HERE

      if http_request_info.has_imsi? || http_request_info.has_msisdn?
        validated_identity = new(
          msisdn: http_request_info.msisdn,
          imsi: http_request_info.imsi,
          mcc: http_request_info.mcc,
          mnc: http_request_info.mnc,
          http_request_info: http_request_info
        )
        validated_identity.send :http_validated!
        validated_identity
      end
    end

    protected

      def http_validated!
        @http_validated = true
      end

  end

end
