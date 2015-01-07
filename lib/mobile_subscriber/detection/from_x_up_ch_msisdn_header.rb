module MobileSubscriber
  module Detection

    # Módulo que provee métodos de deteccion y validacion para MSISDN's de:
    # - Claro Brasil
    module FromXUpChMsisdnHeader

      extend ActiveSupport::Concern

      module ClassMethods
        def extract_from_x_up_ch_msisdn_http_request_header(request)
          header_name = 'X-Up-Ch-Msisdn'
          header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"
          isdn_attributes = nil

          if msisdn = request.env[header_env_key]

            # Determinar la procedencia del MSISDN
            # TODO: Validar por IP, etc.
            isdn_attributes = case

            # Claro BR (Claro):
            when msisdn =~ /\A55/ then {
              id: msisdn,
              mobile_country_code: "724",
              mobile_network_code: "05"
            }

            end if msisdn.length >= 8

          end
          isdn_attributes
        end

      end

    end
  end
end
