require 'mobile_subscriber/dictionaries/dialing_and_country_codes'

module MobileSubscriber::Detection
  # Módulo que provee métodos de detección y validacion para MSISDN por el
  # header de HTTP 'X-Wap-Sesiones3g-Mdn':
  # - Iusacell
  module FromXWapSesiones3gMdnHttpRequestHeader

    def extract_from_x_wap_sesiones3g_mdn_http_request_header(http_request_info)
      if msisdn = http_request_info.headers['X-Wap-Sesiones3g-Mdn'] and msisdn.length >= 8

        country_code = (
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]] ||
          MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,3]]
        )

        # Determine the Network Operator tuple (MCC + MNC):
        # TODO: Validate IP ranges, additional headers, etc.
        network_id_tuple = case country_code
        when 'MX' # Iusacell Mexico:
          # TODO: Determine (if possible) the MNC:
          # - MNC "040": Iusacell/Unefon
          # - MNC "050": Iusacell
          { mcc: "334", mnc: "040" }
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