require 'mobile_subscriber/dictionaries/dialing_and_country_codes'

module MobileSubscriber::Detection
  # Módulo que provee métodos de detección y validacion para MSISDN por el
  # header de HTTP 'X-Ztgo-Beareraddress':
  # - Movistar Ecuador
  module FromXZtgoBeareraddressHttpRequestHeader

    def extract_from_x_ztgo_beareraddress_http_request_header(http_request_info)
      if msisdn = http_request_info.headers['X-Ztgo-Beareraddress'] and msisdn.length >= 8

        country_code = (
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] ||
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]]
        )

        # Determine the Network Operator tuple (MCC + MNC):
        # TODO: Validate IP ranges, additional headers, etc.
        network_id_tuple = case country_code
        when 'EC' # Movistar Ecuador:
          { mcc: "740", mnc: "00" }
        end

        # Return only if we identified the network:
        if network_id_tuple.present?
          {
            id:                   msisdn,
            mobile_country_code:  network_id_tuple[:mcc],
            mobile_network_code:  network_id_tuple[:mnc],
            http_request_info:    http_request_info
          }
        end
      end
    end
  end
end
