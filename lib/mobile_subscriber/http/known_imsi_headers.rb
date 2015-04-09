module MobileSubscriber::HTTP

  # Known IMSI Header and MCC/MNC Tuples:
  KNOWN_IMSI_HEADER_MCC_MNC = {

    'X-Imsi' => [
      ['714', '03'], # Claro Panamá
    ],

    'X-Nokia-Imsi' => [
      ['704', '01' ], # Claro Guatemala
      ['716', '10' ], # Claro Perú
      ['722', '310'], # Claro Argentina
      ['722', '320'], # Claro Argentina
      ['722', '330'], # Claro Argentina
    ],

    'X-Cisco-Imsi' => [
      ['330', '110'], # Claro Puerto Rico
    ]
  }
end
