# encoding: utf-8

Country.create(
  [
    { :code => "af", :name => "Afghanistan", :full_name => "Islamic Republic of Afghanistan"},
    { :code => "al", :name => "Albania", :full_name => "Republic of Albania"},
    { :code => "dz", :name => "Algeria", :full_name => "People's Democratic Republic of Algeria"},
    { :code => "ad", :name => "Andorra", :full_name => "Principality of Andorra"},
    { :code => "ao", :name => "Angola", :full_name => "Republic of Angola"},
    { :code => "ag", :name => "Antigua and Barbuda"},
    { :code => "ar", :name => "Argentine", :full_name => "Argentine Republic"},
    { :code => "am", :name => "Armenia", :full_name => "Republic of Armenia"},
    { :code => "au", :name => "Australia", :full_name => "Commonwealth of Australia"},
    { :code => "at", :name => "Austria", :full_name => "Republic of Austria"},
    { :code => "az", :name => "Azerbaijan", :full_name => "Republic of Azerbaijan"},
    { :code => "bs", :name => "Bahamas", :full_name => "Commonwealth of The Bahamas"},
    { :code => "bh", :name => "Bahrain", :full_name => "Kingdom of Bahrain"},
    { :code => "bd", :name => "Bangladesh", :full_name => "People's Republic of Bangladesh"},
    { :code => "bb", :name => "Barbados"},
    { :code => "by", :name => "Belarus", :full_name => "Republic of Belarus"},
    { :code => "be", :name => "Belgium", :full_name => "Kingdom of Belgium"},
    { :code => "bz", :name => "Belize"},
    { :code => "bj", :name => "Benin", :full_name => "Republic of Benin"},
    { :code => "bt", :name => "Bhutan", :full_name => "Kingdom of Bhutan"},
    { :code => "bo", :name => "Bolivia", :full_name => "Plurinational State of Bolivia"},
    { :code => "ba", :name => "Bosnia and Herzegovina"},
    { :code => "bw", :name => "Botswana", :full_name => "Republic of Botswana"},
    { :code => "br", :name => "Brazil", :full_name => "Federative Republic of Brazil"},
    { :code => "bn", :name => "Brunei", :full_name => "Nation of Brunei, the Abode of Peace"},
    { :code => "bg", :name => "Bulgaria", :full_name => "Republic of Bulgaria"},
    { :code => "bf", :name => "Burkina Faso"},
    { :code => "mm", :name => "Burma", :full_name => "Republic of the Union of Myanmar", :alias => "Myanmar"},
    { :code => "bi", :name => "Burundi", :full_name => "Republic of Burundi"},
    { :code => "kh", :name => "Cambodia", :full_name => "Kingdom of Cambodia"},
    { :code => "cm", :name => "Cameroon", :full_name => "Republic of Cameroon"},
    { :code => "ca", :name => "Canada"},
    { :code => "cv", :name => "Cape Verde", :full_name => "Republic of Cape Verde"},
    { :code => "cf", :name => "Central African Republic"},
    { :code => "td", :name => "Chad", :full_name => "Republic of Chad"},
    { :code => "cl", :name => "Chile", :full_name => "Republic of Chile"},
    { :code => "cn", :name => 'China', :full_name => "People's Republic of China"},
    { :code => "co", :name => "Colombia", :full_name => "Republic of Colombia"},
    { :code => "km", :name => "Comoros", :full_name => "Union of the Comoros"},
    { :code => "cd", :name => "Congo, Democratic Republic of the", :full_name => "Democratic Republic of the Congo", :pretty_name => "Congo-Kinshasa"},
    { :code => "cg", :name => "Congo, Republic of the", :full_name => "Republic of the Congo", :pretty_name => "Congo-Brazzaville"},
    { :code => "cr", :name => "Costa Rica", :full_name => "Republic of Costa Rica"},
    { :code => "ci", :name => "Côte d'Ivoire", :full_name => "Republic of Côte d'Ivoire", :alias => "Ivory Coast"},
    { :code => "hr", :name => "Croatia", :full_name => "Republic of Croatia"},
    { :code => "cu", :name => "Cuba", :full_name => "Republic of Cuba"},
    { :code => "cy", :name => "Cyprus", :full_name => "Republic of Cyprus"},
    { :code => "cz", :name => "Czech Republic", :full_name => "Czech Republic"},
    { :code => "dk", :name => "Denmark", :full_name => "Kingdom of Denmark"},
    { :code => "dj", :name => "Djibouti", :full_name => "Republic of Djibouti"},
    { :code => "dm", :name => "Dominica", :full_name => "Commonwealth of Dominica"},
    { :code => "do", :name => "Dominican Republic"},
    { :code => "tl", :name => "East Timor", :full_name => "Democratic Republic of Timor-Leste"},
    { :code => "ec", :name => "Ecuador", :full_name => "Republic of Ecuador"},
    { :code => "eg", :name => "Egypt", :full_name => "Arab Republic of Egypt"},
    { :code => "sv", :name => "El Salvador", :full_name => "Republic of El Salvador"},
    { :code => "gq", :name => "Equatorial Guinea", :full_name => "Republic of Equatorial Guinea"},
    { :code => "er", :name => "Eritrea", :full_name => "State of Eritrea"},
    { :code => "ee", :name => "Estonia", :full_name => "Republic of Estonia"},
    { :code => "eh", :name => "Western Sahara", :full_name => "Sahrawi Arab Democratic Republic", :alias => 'DISPUTED'},
    { :code => "et", :name => "Ethiopia", :full_name => "Federal Democratic Republic of Ethiopia"},
    { :code => "fj", :name => "Fiji", :full_name => "Republic of Fiji"},
    { :code => "fi", :name => "Finland", :full_name => "Republic of Finland"},
    { :code => "fr", :name => "France", :full_name => "French Republic"},
    { :code => "ga", :name => "Gabon", :full_name => "Gabonese Republic"},
    { :code => "gm", :name => "The Gambia", :full_name => "Republic of The Gambia"},
    { :code => "ge", :name => "Georgia"},
    { :code => "de", :name => "Germany", :full_name => "Federal Republic of Germany"},
    { :code => "gh", :name => "Ghana", :full_name => "Republic of Ghana"},
    { :code => "gr", :name => "Greece", :full_name => "Hellenic Republic"},
    { :code => "gd", :name => "Grenada"},
    { :code => "gt", :name => "Guatemala", :full_name => "Republic of Guatemala"},
    { :code => "gl", :name => "Greenland"},
    { :code => "gn", :name => "Guinea", :full_name => "Republic of Guinea"},
    { :code => "gw", :name => "Guinea-Bissau", :full_name => "Republic of Guinea-Bissau"},
    { :code => "gy", :name => "Guyana", :full_name => "Co-operative Republic of Guyana"},
    { :code => "ht", :name => "Haiti", :full_name => "Republic of Haiti"},
    { :code => "hn", :name => "Honduras", :full_name => "Republic of Honduras"},
    { :code => "hk", :name => "Hong Kong", :full_name => "Hong Kong Special Administrative Region of the People's Republic of China"},
    { :code => "hu", :name => "Hungary"},
    { :code => "is", :name => "Iceland", :full_name => "Republic of Iceland"},
    { :code => "in", :name => "India", :full_name => "Republic of India"},
    { :code => "id", :name => "Indonesia", :full_name => "Republic of Indonesia"},
    { :code => "ir", :name => "Iran", :full_name => "Islamic Republic of Iran"},
    { :code => "iq", :name => "Iraq", :full_name => "Republic of Iraq"},
    { :code => "ie", :name => "Ireland"},
    { :code => "il", :name => "Israel", :full_name => "State of Israel"},
    { :code => "it", :name => "Italy", :full_name => "Italian Republic"},
    { :code => "jm", :name => "Jamaica"},
    { :code => "jp", :name => "Japan"},
    { :code => "jo", :name => "Jordan", :full_name => "Hashemite Kingdom of Jordan"},
    { :code => "kz", :name => "Kazakhstan", :full_name => "Republic of Kazakhstan"},
    { :code => "ke", :name => "Kenya", :full_name => "Republic of Kenya"},
    { :code => "ki", :name => "Kiribati", :full_name => "Republic of Kiribati"},
    { :code => "kp", :name => 'Korea, North', :full_name => "Democratic Peoples Republic of Korea", :pretty_name => "North Korea"},
    { :code => "kr", :name => "Korea, South", :full_name => "Republic of Korea", :pretty_name => "South Korea"},
    { :code => "xk", :name => "Kosovo", :full_name => "Republic of Kosovo"},
    { :code => "kw", :name => "Kuwait", :full_name => "State of Kuwait"},
    { :code => "kg", :name => "Kyrgyzstan", :full_name => "Kyrgyz Republic"},
    { :code => "la", :name => "Laos", :full_name => "Lao People's Democratic Republic"},
    { :code => "lv", :name => "Latvia", :full_name => "Republic of Latvia"},
    { :code => "lb", :name => "Lebanon", :full_name => "Lebanese Republic"},
    { :code => "ls", :name => "Lesotho", :full_name => "Kingdom of Lesotho"},
    { :code => "lr", :name => "Liberia", :full_name => "Republic of Liberia"},
    { :code => "ly", :name => "Libya"},
    { :code => "li", :name => "Liechtenstein", :full_name => "Principality of Liechtenstein"},
    { :code => "lt", :name => "Lithuania", :full_name => "Republic of Lithuania"},
    { :code => "lu", :name => "Luxembourg", :full_name => "Grand Duchy of Luxembourg"},
    { :code => "mo", :name => "Macau", :full_name => "Macao Special Administrative Region of the People's Republic of China"},
    { :code => "mk", :name => "Macedonia", :full_name => "Republic of Macedonia"},
    { :code => "mg", :name => "Madagascar", :full_name => "Republic of Madagascar"},
    { :code => "mw", :name => "Malawi", :full_name => "Republic of Malawi"},
    { :code => "my", :name => "Malaysia"},
    { :code => "mv", :name => "Maldives", :full_name => "Republic of Maldives"},
    { :code => "ml", :name => "Mali", :full_name => "Republic of Mali"},
    { :code => "mt", :name => "Malta", :full_name => "Republic of Malta"},
    { :code => "mh", :name => "Marshall Islands", :full_name => "Republic of the Marshall Islands"},
    { :code => "mr", :name => "Mauritania", :full_name => "Islamic Republic of Mauritania"},
    { :code => "mu", :name => "Mauritius", :full_name => "Republic of Mauritius"},
    { :code => "mx", :name => "Mexico", :full_name => "United Mexican States"},
    { :code => "fm", :name => "Federated States of Micronesia"},
    { :code => "md", :name => "Moldova", :full_name => "Republic of Moldova"},
    { :code => "mc", :name => "Monaco", :full_name => "Principality of Monaco"},
    { :code => "mn", :name => "Mongolia"},
    { :code => "me", :name => "Montenegro"},
    { :code => "ma", :name => "Morocco", :full_name => "Kingdom of Morocco"},
    { :code => "mz", :name => "Mozambique", :full_name => "Republic of Mozambique"},
    { :code => "na", :name => "Namibia", :full_name => "Republic of Namibia"},
    { :code => "nr", :name => "Nauru", :full_name => "Republic of Nauru"},
    { :code => "np", :name => "Nepal", :full_name => "Federal Democratic Republic of Nepal"},
    { :code => "nl", :name => "Netherlands", :full_name => "Kingdom of the Netherlands"},
    { :code => "nz", :name => "New Zealand"},
    { :code => "ni", :name => "Nicaragua", :full_name => "Republic of Nicaragua"},
    { :code => "ne", :name => "Niger", :full_name => "Republic of Niger"},
    { :code => "ng", :name => "Nigeria", :full_name => "Federal Republic of Nigeria"},
    { :code => "nc", :name => "New Caledonia"},
    { :code => "nc1", :name => "Cyprus, Northern", :full_name => "Turkish Republic of Northern Cyprus", :pretty_name => 'Northern Cyprus', :alias => 'DISPUTED'},
    { :code => "no", :name => "Norway", :full_name => "Kingdom of Norway"},
    { :code => "om", :name => "Oman", :full_name => "Sultanate of Oman"},
    { :code => "ps", :name => "Palestine", :full_name => "State of Palestine", :alias => 'DISPUTED'},
    { :code => "pk", :name => "Pakistan", :full_name => "Islamic Republic of Pakistan"},
    { :code => "pw", :name => "Palau", :full_name => "Republic of Palau"},
    { :code => "pa", :name => "Panama", :full_name => "Republic of Panama"},
    { :code => "pg", :name => "Papua New Guinea", :full_name => "Independent State of Papua New Guinea"},
    { :code => "py", :name => "Paraguay", :full_name => "Republic of Paraguay"},
    { :code => "pe", :name => "Peru", :full_name => "Republic of Peru"},
    { :code => "ph", :name => "Philippines", :full_name => "Republic of the Philippines"},
    { :code => "pl", :name => "Poland", :full_name => "Republic of Poland"},
    { :code => "pt", :name => "Portugal", :full_name => "Portuguese Republic"},
    { :code => "pr", :name => "Puerto Rico", :full_name => "Commonwealth of Puerto Rico"},
    { :code => "qa", :name => "Qatar", :full_name => "State of Qatar"},
    { :code => "ro", :name => "Romania"},
    { :code => "ru", :name => "Russia", :full_name => "Russian Federation"},
    { :code => "rw", :name => "Rwanda", :full_name => "Republic of Rwanda"},
    { :code => "kn", :name => "Saint Kitts and Nevis", :full_name => "Federation of Saint Christopher and Nevis"},
    { :code => "lc", :name => "Saint Lucia"},
    { :code => "vc", :name => "Saint Vincent and the Grenadines"},
    { :code => "ws", :name => "Samoa", :full_name => "Independent State of Samoa"},
    { :code => "sm", :name => "San Marino", :full_name => "Republic of San Marino"},
    { :code => "st", :name => "São Tomé and Príncipe", :full_name => "Democratic Republic of São Tomé and Príncipe"},
    { :code => "sa", :name => "Saudi Arabia", :full_name => "Kingdom of Saudi Arabia"},
    { :code => "sn", :name => "Senegal", :full_name => "Republic of Senegal"},
    { :code => "rs", :name => "Serbia", :full_name => "Republic of Serbia"},
    { :code => "sc", :name => "Seychelles", :full_name => "Republic of Seychelles"},
    { :code => "sl", :name => "Sierra Leone", :full_name => "Republic of Sierra Leone"},
    { :code => "sg", :name => "Singapore", :full_name => "Republic of Singapore"},
    { :code => "sk", :name => "Slovakia", :full_name => "Slovak Republic"},
    { :code => "si", :name => "Slovenia", :full_name => "Republic of Slovenia"},
    { :code => "sb", :name => "Solomon Islands"},
    { :code => "so", :name => "Somalia", :full_name => "Somali Republic"},
    { :code => "so1", :name => "Somaliland", :full_name => "Republic of Somaliland", :alias => 'DISPUTED'},
    { :code => "za", :name => "South Africa", :full_name => "Republic of South Africa"},
    { :code => "ss", :name => "South Sudan", :full_name => "Republic of South Sudan"},
    { :code => "es", :name => "Spain", :full_name => "Kingdom of Spain"},
    { :code => "lk", :name => "Sri Lanka", :full_name => "Democratic Socialist Republic of Sri Lanka"},
    { :code => "sd", :name => "Sudan", :full_name => "Republic of the Sudan"},
    { :code => "sr", :name => "Suriname", :full_name => "Republic of Suriname"},
    { :code => "sz", :name => "Swaziland", :full_name => "Kingdom of Swaziland"},
    { :code => "se", :name => "Sweden", :full_name => "Kingdom of Sweden"},
    { :code => "ch", :name => "Switzerland", :full_name => "Swiss Confederation"},
    { :code => "sy", :name => "Syria", :full_name => "Syrian Arab Republic"},
    { :code => "tw", :name => "Taiwan", :full_name => "Republic of China", :alias => "Chinese Taipei"},
    { :code => "tj", :name => "Tajikistan", :full_name => "Republic of Tajikistan"},
    { :code => "tz", :name => "Tanzania", :full_name => "United Republic of Tanzania"},
    { :code => "th", :name => "Thailand", :full_name => "Kingdom of Thailand"},
    { :code => "tg", :name => "Togo", :full_name => "Togolese Republic"},
    { :code => "to", :name => "Tonga", :full_name => "Kingdom of Tonga"},
    { :code => "tt", :name => "Trinidad and Tobago", :full_name => "Republic of Trinidad and Tobago"},
    { :code => "tn", :name => "Tunisia", :full_name => "Republic of Tunisia"},
    { :code => "tr", :name => "Turkey", :full_name => "Republic of Turkey"},
    { :code => "tm", :name => "Turkmenistan"},
    { :code => "tv", :name => "Tuvalu"},
    { :code => "ug", :name => "Uganda", :full_name => "Republic of Uganda"},
    { :code => "ua", :name => "Ukraine"},
    { :code => "ae", :name => "United Arab Emirates"},
    { :code => "gb", :name => 'United Kingdom', :full_name => 'United Kingdom of Great Britain and Northern Ireland'},
    { :code => "us", :name => 'United States', :full_name => 'United States of America'},
    { :code => "uy", :name => "Uruguay", :full_name => "Oriental Republic of Uruguay"},
    { :code => "uz", :name => "Uzbekistan", :full_name => "Republic of Uzbekistan"},
    { :code => "vu", :name => "Vanuatu", :full_name => "Republic of Vanuatu"},
    { :code => "va", :name => "Vatican City", :full_name => "State of the Vatican City"},
    { :code => "ve", :name => "Venezuela", :full_name => "Bolivarian Republic of Venezuela"},
    { :code => "vn", :name => "Vietnam", :full_name => "Socialist Republic of Vietnam"},
    { :code => "ye", :name => "Yemen", :full_name => "Republic of Yemen"},
    { :code => "zm", :name => "Zambia", :full_name => "Republic of Zambia"},
    { :code => "zw", :name => "Zimbabwe", :full_name => "Republic of Zimbabwe"},
    #TODO: move this to its correct position, it needs to be there only for the dumped dbgraphs to work
    { :code => "fk", :name => "Falkland Islands"}
  ]
)