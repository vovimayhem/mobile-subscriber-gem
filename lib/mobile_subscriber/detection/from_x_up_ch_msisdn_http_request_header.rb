module MobileSubscriber
  module Detection

    # Módulo que provee métodos de deteccion y validacion para MSISDN's de:
    # - Claro Brasil
    module FromXUpChMsisdnHttpRequestHeader

      extend ActiveSupport::Concern

      module ClassMethods
        def extract_from_x_up_ch_msisdn_http_request_header(request)
          header_name = 'X-Up-Ch-Msisdn'
          header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"

          isdn_attributes = if msisdn = request.env[header_env_key] and msisdn.length >= 8

            detection_cues = {
              remote_ip: request.env["REMOTE_ADDR"],
              http_request_headers: { 'X-Up-Ch-Msisdn' => msisdn }
            }

            country_code = MobileSubscriber::DIALING_COUNTRY_CODES[msisdn[0,2]]

            # Determinar la procedencia del MSISDN
            # TODO: Validar por IP, etc.
            case country_code
            when 'BR'
              # Claro BR (Claro):
              {
                id: msisdn,
                mobile_country_code: "724",
                mobile_network_code: "05"
              }.merge(detection_cues: detection_cues)
            end

          end
          isdn_attributes
        end

      end

    end
  end
end
