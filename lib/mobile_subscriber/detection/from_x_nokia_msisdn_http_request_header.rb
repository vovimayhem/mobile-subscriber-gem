require 'mobile_subscriber/dictionaries/dialing_and_country_codes'
module MobileSubscriber::Detection

  # Módulo que provee métodos de deteccion y validacion para MSISDN's de:
  # - Telcel México
  # - Claro Argentina
  # - Claro Guatemala
  module FromXNokiaMsisdnHttpRequestHeader

    def extract_from_x_nokia_msisdn_http_request_header(http_request_info)
      if msisdn = http_request_info.headers['X-Nokia-Msisdn'] and msisdn.length >= 8

        country_code = (
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] ||
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]]
        )

        # Determine the Network Operator tuple (MCC + MNC):
        # TODO: Validate IP ranges, additional headers, etc.
        network_id_tuple = case country_code
        when 'MX' # Telcel México:
          { mcc: "334", mnc: "020"  }
        when 'AR' # Claro Argentina:
          { mcc: "722", mnc: "330"  }
        when 'GT' # Claro Guatemala:
          { mcc: "704", mnc: "01"   }
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
