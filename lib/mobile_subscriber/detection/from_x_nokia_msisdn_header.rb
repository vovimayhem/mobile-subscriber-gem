module MobileSubscriber
  module Detection

    # Módulo que provee métodos de deteccion y validacion para MSISDN's de:
    # - Telcel México
    # - Claro Argentina
    module FromXNokiaMsisdnHeader

      extend ActiveSupport::Concern

      module ClassMethods
        def extract_from_x_nokia_msisdn_http_request_header(request)

          header_name = 'X-Nokia-Msisdn'
          header_env_key = "HTTP_#{header_name.gsub('-','_').upcase}"

          isdn_attributes = nil

          if msisdn = request.env[header_env_key]

            # Determinar la procedencia del MSISDN
            # TODO: Validar por IP, etc.
            isdn_attributes = case

            # Telcel México:
            when msisdn =~ /\A52/ then {
              id: msisdn,
              mobile_country_code: "334",
              mobile_network_code: "020"
            }

            # Claro Argentina:
            when msisdn =~ /\A54/ then {
              id: msisdn,
              mobile_country_code: "722",
              mobile_network_code: "330"
            }
            end if msisdn.length >= 8
          end

          isdn_attributes
        end

      end
    end
  end
end
