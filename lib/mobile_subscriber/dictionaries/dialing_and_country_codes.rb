module MobileSubscriber
  # See: http://countrycode.org/
  # Diccionario de Dialing Country Codes => ISO country codes:
  DIALING_COUNTRY_CODES = {
    # Caribbean Islands' country codes are a mess!
    '1809' => 'DO', # Dominican Republic
    '1829' => 'DO', # Dominican Republic Overlay 1
    '1849' => 'DO', # Dominican Republic Overlay 2

    '225' => 'CI',  # Costa de Marfil

    '501'	=> 'BZ',	# Belize
    '502'	=> 'GT',	# Guatemala
    '503'	=> 'SV',	# El Salvador
    '504'	=> 'HN',	# Honduras
    '505'	=> 'NI',	# Nicaragua
    '506'	=> 'CR',	# Costa Rica
    '507'	=> 'PA',	# Panamá
    '509'	=> 'HT',	# Haití
    '51'	=> 'PE',	# Perú
    '52'	=> 'MX',	# México
    '53'	=> 'CU',	# Cuba
    '54'	=> 'AR',	# Argentina
    '55'	=> 'BR',	# Brasil
    '56'	=> 'CL',	# Chile
    '57'	=> 'CO',	# Colombia
    '58'	=> 'VE',	# Venezuela
    '591'	=> 'BO',	# Bolivia
    '593'	=> 'EC',	# Ecuador
    '595'	=> 'PY',	# Paraguay
    '598'	=> 'UY'		# Uruguay
  }.with_indifferent_access.freeze
end
