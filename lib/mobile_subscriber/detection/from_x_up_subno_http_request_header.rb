require 'mobile_subscriber/dictionaries/dialing_and_country_codes'
module MobileSubscriber::Detection
  # Módulo que provee métodos de deteccion y validacion para MSISDN por el
  # header de HTTP 'Msisdn':
  #  - Comcel Colombia
  module FromXUpSubnoHttpRequestHeader

    def extract_from_x_up_subno_http_request_header(http_request_info)
      if msisdn = http_request_info.headers['X-Up-Subno'] and msisdn.length >= 8

        country_code = (
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] ||
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]]
        )

        # Determine the Network Operator tuple (MCC + MNC):
        # TODO: Validate IP ranges, additional headers, etc.
        network_id_tuple = case country_code
        when 'CO' # Comcel Colombia
          { mcc: "732", mnc: "101" }
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
