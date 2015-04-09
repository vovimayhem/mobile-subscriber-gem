module MobileSubscriber::HTTP

  KNOWN_MSISDN_HEADER_MCC_MNC = {

    'Msisdn' => [
      ['370', '02'], # Claro República Dominicana
      ['714', '03'], # Claro Paraguay
      ['724', '05'], # Claro Brasil A
      ['724', '38'], # Claro Brasil B
      ['740', '01'], # Claro Ecuador
    ],

    'X-Cisco-Msisdn' => [
      ['330', '110'], # Claro Puerto Rico
    ],

    'X-Nokia-Msisdn' => [
      ['334', '020'], # Telcel México
      ['704', '01' ], # Claro Guatemala
      ['706', '01' ], # Claro El Salvador
      ['708', '001'], # Claro Honduras
      ['710', '21' ], # Claro Nicaragua
      ['712', '03' ], # Claro Costa Rica
      ['722', '310'], # Claro Argentina A
      ['722', '320'], # Claro Argentina B
      ['722', '330'], # Claro Argentina C
    ],

    'X-Up-Calling-Line-Id' => [
      ['334', '030'], # Movistar México
      ['716', '06' ], # Movistar Perú
      ['716', '10' ], # Claro Perú
      ['722', '010'], # Movistar Argentina
      ['722', '070'], # Movistar Argentina
      ['724', '02' ], # TIM (Telecom Italia Mobile) Brasil A
      ['724', '03' ], # TIM (Telecom Italia Mobile) Brasil B
      ['724', '04' ], # TIM (Telecom Italia Mobile) Brasil C
      ['724', '30' ], # OI Brasil
      ['724', '31' ], # OI Brasil
    ],

    'X-Up-Ch-Msisdn' => [
      ['724', '06'], # Vivo Brasil
      ['724', '10'], # Vivo Brasil
      ['724', '11'], # Vivo Brasil
      ['724', '23'], # Vivo Brasil
    ],

    'X-Up-Subno' => [
      ['732', '101'], # Claro Colombia and former Comcel Colombia
      ['714', '03' ], # Claro Panamá
    ],

    'X-Wap-Msisdn' => [
      ['730', '03' ], # Claro Chile
    ],

    'X-Wap-Sesiones3g-Mdn' => [
      ['334', '040'], # Iusacell México
      ['334', '050'], # Iusacell México
    ],

    'X-Ztgo-Beareraddress' => [
      ['740', '00'], # Movistar Ecuador
    ],
  }

end
