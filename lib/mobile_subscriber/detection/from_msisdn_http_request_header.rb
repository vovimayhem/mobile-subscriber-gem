require 'mobile_subscriber/dictionaries/dialing_and_country_codes'

module MobileSubscriber::Detection

  # Módulo que provee métodos de detección y validacion para MSISDN por el
  # header de HTTP 'Msisdn':
  # - Claro Brasil
  # - Claro Chile
  # - Claro Colombia
  # - Claro Costa Rica
  # - Claro República Dominicana
  # - Claro Ecuador
  # - Claro El Salvador
  # - Claro Honduras
  # - Claro Nicaragua
  # - Claro Panamá
  # - Claro Paraguay
  module FromMsisdnHttpRequestHeader

    def extract_from_msisdn_http_request_header(http_request_info)
      if msisdn = http_request_info.headers['Msisdn'] and msisdn.length >= 8

        country_code = (
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] ||
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]] ||
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,4]]     # Dominican Republic
        )

        # Determine the Network Operator (MCC + MNC tuple):
        # TODO: Validate IP ranges, additional headers, etc.
        network_id_tuple = case country_code
        when 'BR' # Claro Brasil
          # TODO: Determine (if possible) the MNC (05, 38)
          { mcc: "724", mnc: "05"   }
        when 'CL' # Claro Chile
          { mcc: "730", mnc: "03"   }
        when 'CO' # Claro Colombia
          { mcc: "732", mnc: "101"  }
        when 'CR' # Claro Costa Rica
          { mcc: "712", mnc: "03"   }
        when 'DO' # Claro Dominicana:
          { mcc: "370", mnc: "02"   }
        when 'EC' # Claro Ecuador:
          { mcc: "740", mnc: "01"   }
        when 'SV' # Claro El Salvador:
          { mcc: "706", mnc: "01"   }
        when 'HN' # Claro Honduras:
          { mcc: "708", mnc: "001"  }
        when 'NI' # Claro Nicaragua:
          { mcc: "710", mnc: "21"   }
        when 'PA' # Claro Panamá:
          { mcc: "714", mnc: "03"   }
        when 'PY' # Claro Paraguay:
          { mcc: "744", mnc: "02"   }
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
