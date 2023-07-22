import 'package:flutter/material.dart';

class CallHospitalModel {
  String? name, address;
  IconData? icon;
  int? call;

  CallHospitalModel({this.name, this.address, this.icon, this.call});
}

List<CallHospitalModel> allHospitalList = [
  CallHospitalModel(
    name: 'Ad-din Akij Medical College Hospital',
    address: '2 Bara Maghbazar, Dhaka-1217',
    icon: Icons.call,
    call: 9353391,
  ),
  CallHospitalModel(
    name: 'Ad-din Sakina Medical College Hospital',
    address: '15 Rail Road, Jessore',
    icon: Icons.call,
    call: 01713 - 488460,
  ),
  CallHospitalModel(
    name: 'Ad-din Hospital Kushtia',
    address: '19/1 Chand Mohammad Sarak Thanapara, Kushtia',
    icon: Icons.call,
    call: 01713 - 488427,
  ),
  CallHospitalModel(
    name: 'Ad-din Eye Hospital',
    address: 'Chanchra, Dalmil Jessore',
    icon: Icons.call,
    call: 01713488409,
  ),
  CallHospitalModel(
    name: 'Ad-din Barrister Rafiq-Ul-HuqHospital',
    address: '23/1 Postogola, Jurain, Dhaka',
    icon: Icons.call,
    call: 01713488426,
  ),
  CallHospitalModel(
    name: 'Ad-din Akij Medical College Hospital',
    address: 'Boyra, Khulna',
    icon: Icons.call,
    call: 01713488421,
  ),
  CallHospitalModel(
    name: 'Addin Children Hospital',
    address: 'Poridarshan Banglo Sarak, Karbala, Jessore',
    icon: Icons.call,
    call: 01718 - 206749,
  ),
  CallHospitalModel(
    name: "Appolo Hospital",
    address: "20/5, Babar Road, (Ground Floor), Block # B, Mohammadpur",
    icon: Icons.call,
    call: 8152549,
  ),
  CallHospitalModel(
    name: 'Aichi Hospital',
    address: 'House # 13, Eshakha Avenue Sector # 6, utttara Dhaka',
    icon: Icons.call,
    call: 8916290,
  ),
  CallHospitalModel(
    name: 'Al Anaiet Adhunik Hospital',
    address: 'House # 36, Road # 3, Dhanmondi',
    icon: Icons.call,
    call: 8631619,
  ),
  CallHospitalModel(
    name: 'Ahmed Medical Centre Ltd',
    address: 'House # 71, Road # 15-A, (New), Dhanmondi C/A',
    icon: Icons.call,
    call: 8113628,
  ),
  CallHospitalModel(
    name: 'Al-Madina General Hospital (Pvt.) Ltd',
    address: '2/A, Golden Street, Ring Road, Shamoli, Dhaka',
    icon: Icons.call,
    call: 8118709,
  ),
  CallHospitalModel(
    name: 'Arogya Niketan Hospital Ltd',
    address: '242-243, New Circular Road, Malibagh',
    icon: Icons.call,
    call: 9333730,
  ),
  CallHospitalModel(
    name: 'Al- Rajhi Hospital',
    address: '12, Farmgate-1215, Dhaka',
    icon: Icons.call,
    call: 8119229,
  ),
  CallHospitalModel(
    name: 'Al Jebel-E-Nur Heart Ltd',
    address: 'House # 21, Road # 9/A (New),Dhanmondi',
    icon: Icons.call,
    call: 8117031,
  ),
  CallHospitalModel(
    name: 'Al-Biruni Hospital',
    address: '23/1, Khilzee Road, Shyamoli',
    icon: Icons.call,
    call: 8118905,
  ),
  CallHospitalModel(
    name: 'Al-Markazul Islami Hospital',
    address: '21/17, Babar Road, Mohammadpur',
    icon: Icons.call,
    call: 8114980,
  ),
  CallHospitalModel(
    name: 'Al-Mohite General Hospital & Diagnostic Centre',
    address: 'House # 11, Road # 2, Shyamoli',
    icon: Icons.call,
    call: 9113831,
  ),
  CallHospitalModel(
    name: 'Aysha Memorial Specialized Hospital',
    address: '74/G, Arjatpara, Mohakhali, Dhaka',
    icon: Icons.call,
    call: 9122689,
  ),
  CallHospitalModel(
    name: 'Al- Helal Speacialist Hospital',
    address: '150,Rokeya Sarani Senpara ParbataMirpur-10, Dhaka',
    icon: Icons.call,
    call: 9006820,
  ),
  CallHospitalModel(
    name: 'Al-Ahsraf General Hospital',
    address: 'House # 12 Road # 21,Sector # 4,Uttara Dhaka',
    icon: Icons.call,
    call: 8952851,
  ),
  CallHospitalModel(
    name: 'Al-Fateh Medical Sevices (Pvt) Ltd',
    address: '11, Farmgate over Bridge East Side',
    icon: Icons.call,
    call: 9120615,
  ),
  CallHospitalModel(
    name: 'Al-Manar Hospital',
    address: '5/4, Block-F, Lalmatia Dhaka - 1207',
    icon: Icons.call,
    call: 9121387,
  ),
  CallHospitalModel(
    name: 'Al Haramain Hospital',
    address:
    'Kazi Tower, Samata-30, Chali Bandar, Bishwa Road, Subhani Ghat, Sylhet-3100',
    icon: Icons.call,
    call: 01931225555,
  ),
  CallHospitalModel(
    name: 'Ambia Memorial Hospital',
    address: 'Barisal',
    icon: Icons.call,
    call: 01717214193,
  ),
  CallHospitalModel(
    name: 'Anwer Khan Modern Hospital Ltd',
    address: 'H-17,R-8,Dhanmondi,Dhaka',
    icon: Icons.call,
    call: 10652,
  ),
  CallHospitalModel(
    name: 'Basundhara Addin Medical College Hospital',
    address:
    'Bashundhara River view Residential Project, South keraniganj, Dhaka.',
    icon: Icons.call,
    call: 0171348841516,
  ),
  CallHospitalModel(
    name: 'Brain & Maind Hospital Ltd',
    address: '149/A, Airport Road, Farmgate, Baityl Shoraf Mosque Complex',
    icon: Icons.call,
    call: 8120710,
  ),
  CallHospitalModel(
    name: 'Bengal Nursing Home (Pvt.) Ltd',
    address: ' 70/C, Clke Circus kalabagan',
    icon: Icons.call,
    call: 8116007,
  ),
  CallHospitalModel(
    name: 'Bangkok Hospital',
    address:
    'Office, Bangladesh Lion Complex (4th Floor), 73, New Airport Road, Tejgaon',
    icon: Icons.call,
    call: 9139777,
  ),
  CallHospitalModel(
    name: 'B.D.F. Hospital',
    address: '5/7, Humayaun Road, Block # D, Mohammadpur',
    icon: Icons.call,
    call: 8123730,
  ),
  CallHospitalModel(
    name: 'Bnsb Dhaka',
    address: 'Eye Hospital Mirpur-1, Dhaka',
    icon: Icons.call,
    call: 8014476,
  ),
  CallHospitalModel(
    name: 'Brighton Hospital Ltd',
    address: '163, Sonargaon Road Hatirpool, Dhaka - 1205',
    icon: Icons.call,
    call: 9671186,
  ),
  CallHospitalModel(
    name: 'Bangabandhu Shiekh Mujib Medical University',
    address: 'Shabagh, Dhaka',
    icon: Icons.call,
    call: 8614545,
  ),
  CallHospitalModel(
    name: 'BIRDEM General Hospital',
    address: 'Shahbagh, Dhaka',
    icon: Icons.call,
    call: 8616641,
  ),
  CallHospitalModel(
    name: 'Bdm Hospital',
    address: '5/17, Humaund Road, Block # B, Mohammadpur',
    icon: Icons.call,
    call: 8113481,
  ),
  CallHospitalModel(
    name: 'Bangladesh Telemedicine Services Ltd',
    address: 'Comfort Tower, 167/B, Green Road, Dhanmondi',
    icon: Icons.call,
    call: 8124990,
  ),
  CallHospitalModel(
    name: 'Bangal Nursing Home Ltd',
    address: 'Lake Circus, Kalabagan, Dhaka',
    icon: Icons.call,
    call: 9114824,
  ),
  CallHospitalModel(
    name: 'Bumrungrad Hospital',
    address: 'House- 154, Road- 11, Block- E, Banani, Dhaka',
    icon: Icons.call,
    call: 8855254,
  ),
  CallHospitalModel(
    name: 'Bari-Llizarov Orthopedic',
    address:
    'Centre House # 77 (New) 831 (Old), Road # 9/A (New) 19 (Old), Dhanmondi R/A',
    icon: Icons.call,
    call: 8117876,
  ),
  CallHospitalModel(
    name: 'Bangladesh Medical College',
    address: 'House # 35, Road # 14/A, Dhanmondi',
    icon: Icons.call,
    call: 8115843,
  ),
  CallHospitalModel(
    name: 'Bangladesh Heart & Chest Hospital',
    address: 'Road # 27 (Old), 16 (New), House # 47, Dhanmondi',
    icon: Icons.call,
    call: 8123977,
  ),
  CallHospitalModel(
    name:
    'Bangladesh Association For The Aged & Institute Of Gerecitric Medicine',
    address: 'Agargaon, Sher-e-Bangla Nagar',
    icon: Icons.call,
    call: 9129814,
  ),
  CallHospitalModel(
    name: 'CMH (Dhaka Cantonment)',
    address: 'Dhaka',
    icon: Icons.call,
    call: 882770,
  ),
  CallHospitalModel(
    name: 'Chandshi Medical Centre',
    address: 'House # 9, Road # 27, Block # K, Banani',
    icon: Icons.call,
    call: 9554571,
  ),
  CallHospitalModel(
    name: 'Centre For The Rehabilitation Of The Paralysed (Crp)',
    address: 'Post CRP Chapin, Savar',
    icon: Icons.call,
    call: 7711766,
  ),
  CallHospitalModel(
    name: 'Community Hospital',
    address: '190/1, Wireless Rail Gate, Baramaghbazar, Dhaka',
    icon: Icons.call,
    call: 9351190,
  ),
  CallHospitalModel(
    name: 'China-Bangla Hospital (Jv) Ltd',
    address: 'Plot # 1, Road # 7, Sector # 1, Uttara',
    icon: Icons.call,
    call: 8913606,
  ),
  CallHospitalModel(
    name: 'Christian Medical Hospital',
    address: '6/3, Badda, Baridhara (North)',
    icon: Icons.call,
    call: 8813375,
  ),
  CallHospitalModel(
    name: 'Cholera Hospital (Icddrb)',
    address: 'Dhaka, Mohkhali',
    icon: Icons.call,
    call: 871751,
  ),
  CallHospitalModel(
    name: 'Central Hospital Ltd',
    address: 'House # 2, Road # 5, Green Road, Dhanmondi',
    icon: Icons.call,
    call: 9660015,
  ),
  CallHospitalModel(
    name: 'Crescent Hospital & Diagnostic Complex Ltd',
    address: '22/2, Babor Road, Mohammadpur',
    icon: Icons.call,
    call: 8119775,
  ),
  CallHospitalModel(
    name: 'Centre For Health And Development Medical Complex',
    address:
    '(Chd Medical Comple) House # 16, Road # 16, Sector # 4, Uttara Model Town',
    icon: Icons.call,
    call: 8920670,
  ),
  CallHospitalModel(
    name: 'City Hospital (Pvt) Ltd',
    address: '69/1/1, Panthapath',
    icon: Icons.call,
    call: 8623205,
  ),
  CallHospitalModel(
    name: 'Care Madical Center Ltd',
    address: '41, Chamelibagh, Shantinagar',
    icon: Icons.call,
    call: 9351190,
  ),
  CallHospitalModel(
    name: 'Crescent Hospital & Dignostic',
    address: '22/2, Babar Road, Mohammadpur, Dhaka',
    icon: Icons.call,
    call: 8119775,
  ),
  CallHospitalModel(
    name: 'Cancer Home Cancer & Breast Clinic',
    address: 'GP-Cha, 149/1, Mohakhali',
    icon: Icons.call,
    call: 8815244,
  ),
  CallHospitalModel(
    name: 'Community Maternity Hospital',
    address: '22, Bijay Nagar',
    icon: Icons.call,
    call: 9358513,
  ),
  CallHospitalModel(
    name: 'Crescent Gastroliver & General Hospital Ltd',
    address: 'House- 60, Road- 8/A, Dhanmondi R/A, Dhaka',
    icon: Icons.call,
    call: 9116851,
  ),
  CallHospitalModel(
    name: 'Control Of Diarrhoeal Disease Programme',
    address: '1/13, Humayun Road, Block # B, Mohammadpur',
    icon: Icons.call,
    call: 9114581,
  ),
  CallHospitalModel(
    name: 'Delta Medical Centre Ltd',
    address: 'House # 20, Raod # 4, Dhanmondi R/A',
    icon: Icons.call,
    call: 86171413,
  ),
  CallHospitalModel(
    name: 'Dhaka Community Hospital',
    address: '190/1, Baro Moghbazar, Wireless Railgate',
    icon: Icons.call,
    call: 935119091,
  ),
  CallHospitalModel(
    name: 'Dhaka Ent (Ear, Nose, Thot) Hospital',
    address: 'House # 56, Road # 4/A, Dhanmondi R/A',
    icon: Icons.call,
    call: 8617503,
  ),
  CallHospitalModel(
    name: 'Dhaka General Hospital (Pvt) Ltd',
    address: '17, Hatkhola Road',
    icon: Icons.call,
    call: 7115351,
  ),
  CallHospitalModel(
    name: 'Dhaka Medical College & Hospital',
    address: 'Polashi, Dhaka',
    icon: Icons.call,
    call: 9663429,
  ),
  CallHospitalModel(
    name: 'Dhaka Monorogh Clinic',
    address: 'House # 13, Road # I Block # 11/A, Mirpur Dhaka',
    icon: Icons.call,
    call: 9005050,
  ),
  CallHospitalModel(
    name: 'Dhaka National Hospital Ltd',
    address: '843, Ring Road, Shamoli, Dhaka-1207',
    icon: Icons.call,
    call: 912603,
  ),
  CallHospitalModel(
    name: 'Dhaka Renal Centre & General Hospital',
    address: '5 Green Corner, Green Road,Dhaka-1205',
    icon: Icons.call,
    call: 8610928,
  ),
  CallHospitalModel(
    name: 'Dhaka Shishu Hospital',
    address: 'Sher-E-Bangla Nagar, Dhaka',
    icon: Icons.call,
    call: 811606162,
  ),
  CallHospitalModel(
    name: 'Dhanmondi Hospital (Pvt) Ltd',
    address: 'House # 19/E, Green Road, Middle of Road # 6 & 7, Dhanmondi',
    icon: Icons.call,
    call: 8628849,
  ),
  CallHospitalModel(
    name: 'Diabetic Association Of Bangladesh',
    address: '122, Kazi Nazrul Islam Avenue, Shahbagh',
    icon: Icons.call,
    call: 861664150,
  ),
  CallHospitalModel(
    name: 'Diganta Anti Drug Hospital',
    address: 'House # 353, Road # 14, Block # B, Chanduaon R/A',
    icon: Icons.call,
    call: 031671393,
  ),
  CallHospitalModel(
    name: 'Doctors General Hospital',
    address: '31/32, DIT Industrial Area, Postogola',
    icon: Icons.call,
    call: 7410731,
  ),
  CallHospitalModel(
    name: 'Dr. Salahudding Hospital',
    address: 'House # 37, Road # 9/A, Dhanmondi R/A',
    icon: Icons.call,
    call: 9122264,
  ),
  CallHospitalModel(
    name: 'Dr. Sultanas Poly Clinic',
    address: '651, Shahinbagh, Tejgaon',
    icon: Icons.call,
    call: 9115244,
  ),
  CallHospitalModel(
    name: 'Dushta Shasthya Hospital',
    address: '(D.S.K) 21/1, Khilji Road, Mohammadpur',
    icon: Icons.call,
    call: 8124952,
  ),
  CallHospitalModel(
    name: 'Eden Multicare Hospital',
    address: '753, Satmasjid Road Dhanmondi, Dhaka-1209',
    icon: Icons.call,
    call: 8151506,
  ),
  CallHospitalModel(
    name: 'Eastern Care Hospital Limited',
    address: '7, 3 Gate-2, Dhaka 1207',
    icon: Icons.call,
    call: 0255008256,
  ),
  CallHospitalModel(
    name: 'Esperto Health Care Limited',
    address: 'House No. 05, 05 Rd 27, Dhaka 1209',
    icon: Icons.call,
    call: 029117255,
  ),
  CallHospitalModel(
    name: 'Farabi General Hospital',
    address: 'Road # 14 (New), House # 8/3,Dhanmondi R/A, Dhaka-1209',
    icon: Icons.call,
    call: 9140442,
  ),
  CallHospitalModel(
    name: 'Fashion Eye Hospital Ltd',
    address: '98/6-A, Elephant Road, Bara Moghbazar',
    icon: Icons.call,
    call: 9343961,
  ),
  CallHospitalModel(
    name: 'Faud Al Khatib Hospital',
    address: 'Almas Tower, 282/1, 1st Colony, Majar Road, Mirpur',
    icon: Icons.call,
    call: 9004317,
  ),
  CallHospitalModel(
    name: 'Federal Medical College Hospital Ltd',
    address: '20, Link Road, Bangla Motor',
    icon: Icons.call,
    call: 86130978,
  ),
  CallHospitalModel(
    name: 'Farazy Hospital Ltd.',
    address: 'House No#15, 19 Banasree Main Rd, Dhaka 1219',
    icon: Icons.call,
    call: 01952289332,
  ),
  CallHospitalModel(
    name: 'Gastroliver Hospital & Research Institute',
    address: '69/D, Green Road Panthpath,Dhaka-1205',
    icon: Icons.call,
    call: 8620960,
  ),
  CallHospitalModel(
    name: 'General Hospital Ltd',
    address: 'House # 60, Road # 8/A, Dhanmondi, R/A, Dhaka',
    icon: Icons.call,
    call: 9116851,
  ),
  CallHospitalModel(
    name: 'General Medical Hospital (Pvt.) Ltd',
    address: '103, Elephant Road, Dhaka-1205',
    icon: Icons.call,
    call: 861932,
  ),
  CallHospitalModel(
    name: 'Grain & Mind Hospital Ltd',
    address: '149/A, Airport Road, Farmgate, Baitus Sharaf Mosque Complex',
    icon: Icons.call,
    call: 8120710,
  ),
  CallHospitalModel(
    name: 'Green Hospital',
    address: 'House # 31, Road # 6, Dhanmondi R/A',
    icon: Icons.call,
    call: 8612412,
  ),
  CallHospitalModel(
    name: 'GreenLand Hospital',
    address: 'House # 4, Road # 4, Sector # 7, Uttara Model Town',
    icon: Icons.call,
    call: 8912663,
  ),
  CallHospitalModel(
    name: 'Harun Eye Foundation & Green Hospital',
    address: 'Road # 6, House # 31, Dhanmondi R/A, Dhaka',
    icon: Icons.call,
    call: 8612412,
  ),
  CallHospitalModel(
    name: 'Hasnabad Hospital (Pvt) Ltd',
    address: 'South West Side of Buri Ganga Bridge, Hasnabad',
    icon: Icons.call,
    call: 7419977,
  ),
  CallHospitalModel(
    name: 'Health And Hope Ltd',
    address:
    '152/1-H, Green Road, Panthopath (Green Road - Panthopath Crossing)',
    icon: Icons.call,
    call: 9145786,
  ),
  CallHospitalModel(
    name: 'Holy Family R. C. Hospital',
    address: 'Eskaton Garden Road, Dhaka',
    icon: Icons.call,
    call: 831172125,
  ),
  CallHospitalModel(
    name: 'Hyfia General Hospital',
    address: '1/A, Adabar, Ring Road, Shamoli, Dhaka',
    icon: Icons.call,
    call: 9120519,
  ),
  CallHospitalModel(
    name: 'I.R. Ltd',
    address: 'House # 50, Road # 2A Dhanmondi',
    icon: Icons.call,
    call: 8618085,
  ),
  CallHospitalModel(
    name: 'Ibn Sina Hospital',
    address: 'House # 47, Road # 9/A, Satmasjid Road, Dhanmondi',
    icon: Icons.call,
    call: 91266255,
  ),
  CallHospitalModel(
    name: 'Icddrb',
    address: 'Mohakhali',
    icon: Icons.call,
    call: 881175160,
  ),
  CallHospitalModel(
    name: 'Institute Of Chestdiseases Hospital',
    address: 'Mohakhali, Dhaka',
    icon: Icons.call,
    call: 881626872,
  ),
  CallHospitalModel(
    name: 'Institute Of Child Health And Shishu Hospital',
    address: '6/2, Barabag, Section # 2, Mirpur',
    icon: Icons.call,
    call: 80238945,
  ),
  CallHospitalModel(
    name: 'International Hospital',
    address: '6, Eskaton Garden, Moghbazar',
    icon: Icons.call,
    call: 9333739,
  ),
  CallHospitalModel(
    name: 'Islami Bank Hospital',
    address: '24/B, Outer Cercular Road, Dhaka',
    icon: Icons.call,
    call: 9336421,
  ),
  CallHospitalModel(
    name: 'Islamia Arogya Sadan Ltd',
    address: 'House # 35, Road # 1, Dhanmondi R/A',
    icon: Icons.call,
    call: 8631988,
  ),
  CallHospitalModel(
    name: 'Islamia Eye Hospital',
    address: 'Farmgate, Dhaka',
    icon: Icons.call,
    call: 9119315,
  ),
  CallHospitalModel(
    name: 'Jahangirnagar Hospital Ltd',
    address: '34/1, Manir Hossain Lane, Swamibagh New Road, Dhajagonj',
    icon: Icons.call,
    call: 71251524,
  ),
  CallHospitalModel(
    name: 'Khaliqun Nessa General Hospital',
    address: '61, Becharam Dewri',
    icon: Icons.call,
    call: 7313583,
  ),
  CallHospitalModel(
    name: 'Kumudini Hospital',
    address: 'Mirzapur, Tangail',
    icon: Icons.call,
    call: 9849637,
  ),
  CallHospitalModel(
    name: 'Khwaja Yunus Ali Medical College and Hospital',
    address: 'Enayetpur, Chauhali,Sirajganj-6751, Bangladesh',
    icon: Icons.call,
    call: 01716291681,
  ),
  CallHospitalModel(
    name: 'Lion Foundation Eye Hospital',
    address: 'Lions Bhaban, Begum Rokya Sarani, Agargoan, Dhaka',
    icon: Icons.call,
    call: 9131990,
  ),
  CallHospitalModel(
    name: 'Made H Clinic',
    address: '62, Lake Circus, Kalabagan',
    icon: Icons.call,
    call: 9112076,
  ),
  CallHospitalModel(
    name: 'Maf Air Support',
    address: 'House # 299, Lane # 4, DOHS, Baridhara',
    icon: Icons.call,
    call: 8810164,
  ),
  CallHospitalModel(
    name: 'Medi Prime Orthopaedic Hospital',
    address: '1/9, Humayan Road, College Gate,Mohammadpur, Dhaka-1207',
    icon: Icons.call,
    call: 9139226,
  ),
  CallHospitalModel(
    name: 'Medistine Hospital',
    address: '218, Outer Circular Road,Moghbazar, Dhaka',
    icon: Icons.call,
    call: 9345003,
  ),
  CallHospitalModel(
    name: 'Meditech General Hospital (Pvt) Ltd',
    address: 'House # 21, Road # 2, Nikunja',
    icon: Icons.call,
    call: 28918345,
  ),
  CallHospitalModel(
    name: 'Meriland Hospital',
    address: 'Sector # 1, Road # 13, House # 4, Uttara',
    icon: Icons.call,
    call: 8919481,
  ),
  CallHospitalModel(
    name: 'Millennium Heart & Feneral Hospital',
    address: '4/9, Block # F, Lalmatia, Mohammadpur',
    icon: Icons.call,
    call: 9122115,
  ),
  CallHospitalModel(
    name: 'Mirpur General Hospital',
    address: 'House # 35, Road # 1, Sector # 10, Mirpur',
    icon: Icons.call,
    call: 8015444,
  ),
  CallHospitalModel(
    name: 'Mirpur Holy Crescent Hospital (Pvt) Ltd',
    address: '33, South Bishil, Mirpur-1, Dhaka',
    icon: Icons.call,
    call: 9000633,
  ),
  CallHospitalModel(
    name: 'Modern Clinic Of Surgery & Midwifery',
    address: 'House # 5, Road # 11, Gulshan - 1',
    icon: Icons.call,
    call: 8821578,
  ),
  CallHospitalModel(
    name: 'Modern Harbal',
    address: '12, Shantinagar',
    icon: Icons.call,
    call: 9358052,
  ),
  CallHospitalModel(
    name: 'Mujibunnessa Eye Hospital Ltd',
    address: 'House # 11 (New), Road # 28 (Old) 25 (New), Dhanmondi R/A, Dhaka',
    icon: Icons.call,
    call: 9130701,
  ),
  CallHospitalModel(
    name: 'Monon Psychiatry Hospital',
    address: '150, Mohammadpur (VIP Road),Dhaka',
    icon: Icons.call,
    call: 9131958,
  ),
  CallHospitalModel(
    name: 'Mother Care Hospital (Pvt.) Ltd',
    address: '3/10, Lalmatia, Block - A, Mirpur Road',
    icon: Icons.call,
    call: 9119355,
  ),
  CallHospitalModel(
    name: 'Munsor Ali Medical College',
    address: 'Sector # 11, Road # 19, Plot # 1/C, Chowrasta, Uttara',
    icon: Icons.call,
    call: 8917978,
  ),
  CallHospitalModel(
    name: 'National Diagnostic Network (Ndn)',
    address: '69-M, Green Raod, Panthapath',
    icon: Icons.call,
    call: 8610647,
  ),
  CallHospitalModel(
    name: 'National Heart Foundation Hospital',
    address: 'Mirpur-2, Dhaka',
    icon: Icons.call,
    call: 8014914,
  ),
  CallHospitalModel(
    name: 'National Medical College & Hospital',
    address: '53/1, Johnson Road, Dhaka',
    icon: Icons.call,
    call: 7117300,
  ),
  CallHospitalModel(
    name: 'Neurology Foundation & Hospital',
    address: '3/1, Lake Circus, Kalabagan, Dhaka-1205',
    icon: Icons.call,
    call: 8114846,
  ),
  CallHospitalModel(
    name: 'New Mukti Clinic',
    address: '301, Elephant Road, Dhaka',
    icon: Icons.call,
    call: 8611360,
  ),
  CallHospitalModel(
    name: 'North South Medical Centre',
    address: '19/10, Babur Road, Block - B, Mohammadpur',
    icon: Icons.call,
    call: 9126089,
  ),
  CallHospitalModel(
    name: 'O. S. B Eye Hospital',
    address: 'Mirpur, Dhaka',
    icon: Icons.call,
    call: 9003088,
  ),
  CallHospitalModel(
    name: 'Ogsb Maternity Hospital',
    address: 'Edgha Mohdhan Zoo Road Mirpur -1, Dhaka',
    icon: Icons.call,
    call: 9005490,
  ),
  CallHospitalModel(
    name: 'Orthopedic Hospital (Pangu Hospital)',
    address: 'Shere-e-Bangla Nagar',
    icon: Icons.call,
    call: 9114075,
  ),
  CallHospitalModel(
    name: 'Padma General Hospital Ltd',
    address: '290, Sonargaon Road',
    icon: Icons.call,
    call: 9662502,
  ),
  CallHospitalModel(
    name: 'Pan Pacific Hospital & Training & Recerch Ins',
    address: '24, Outer Circular Road, South Shahjahanpur',
    icon: Icons.call,
    call: 9351777,
  ),
  CallHospitalModel(
    name: 'Parkway Healthcare Infomation Centre Suite',
    address: 'B3, Level -10, Road # 53, Gulshan - 2',
    icon: Icons.call,
    call: 8850423,
  ),
  CallHospitalModel(
    name: 'Penta Star Hospital',
    address: '161/A, Kalabagan, Lakecircus',
    icon: Icons.call,
    call: 9113131,
  ),
  CallHospitalModel(
    name: 'Proshanti Hospital Ltd',
    address: '6, Shantibagh, 3 Outer Citcular Road',
    icon: Icons.call,
    call: 9348728,
  ),
  CallHospitalModel(
    name: 'Renaissance Hosspital & Research Institute Ltd',
    address: 'House # 60/A, Road # 4/A, Dhanmondi',
    icon: Icons.call,
    call: 9664930,
  ),
  CallHospitalModel(
    name: 'Rihd Pangu Hospital',
    address: 'Sher-E-Bangla Nagar, Dhaka',
    icon: Icons.call,
    call: 91192348,
  ),
  CallHospitalModel(
    name: 'Rmc Hospital & Dignostic Complex Ltd',
    address: 'House # 19, Road # 5, Sector # 7 Uttara Dhaka-1230',
    icon: Icons.call,
    call: 8952157,
  ),
  CallHospitalModel(
    name: 'Rog Mukti General Hospital',
    address: '24, DIT Plot, Postogola',
    icon: Icons.call,
    call: 7410504,
  ),
  CallHospitalModel(
    name: 'Rushmono General Hospital',
    address: '208-9, Outer Circular Road,Moghbazar, Dhaka-1217',
    icon: Icons.call,
    call: 8317606,
  ),
  CallHospitalModel(
    name: 'S.P.R.C. Hospital',
    address: '62, Bara Moghbazar',
    icon: Icons.call,
    call: 9342744,
  ),
  CallHospitalModel(
    name: 'Salvation Specialized Hospital',
    address: 'House No- 36,Road No- 3,Dhanmondi R/A',
    icon: Icons.call,
    call: 9674114,
  ),
  CallHospitalModel(
    name: 'Shyamoly Orthopaedic Hospital',
    address: '3/KA, RC Culture Housing Society, Ring Road, Shyamoli, Dhaka',
    icon: Icons.call,
    call: 9121832,
  ),
  CallHospitalModel(
    name: 'Savar General Hospital',
    address: 'WAPDA Road (1st & 2nd flr.), Malancha, Savar',
    icon: Icons.call,
    call: 06226848,
  ),
  CallHospitalModel(
    name: 'Shaheed Suhrwardi Hospital',
    address: 'Sher-E-Banglanagar, Dhaka',
    icon: Icons.call,
    call: 8113478,
  ),
  CallHospitalModel(
    name: 'Shazada General Hospital',
    address: 'Block - D, 1/30, Kalwalapara, Mirpur - 1',
    icon: Icons.call,
    call: 8014860,
  ),
  CallHospitalModel(
    name: 'Shefa Nurshing Home',
    address: '12/10, Babur Road, Block # B, Mohammadpur',
    icon: Icons.call,
    call: 8010916,
  ),
  CallHospitalModel(
    name: 'Shishu Foundation Hospital',
    address: 'Bara Bagh, Mirpur',
    icon: Icons.call,
    call: 9001090,
  ),
  CallHospitalModel(
    name: 'Sir Salimullah Medical College & Mitford Hospital',
    address: 'Dhaka',
    icon: Icons.call,
    call: 7117404,
  ),
  CallHospitalModel(
    name: 'Sonargaon Health Care (Pvt.) Ltd',
    address:
    'House # 99 (1st Floor), Road # 11/A, (Satmosjid Road), Dhanmondi R/A',
    icon: Icons.call,
    call: 8118823,
  ),
  CallHospitalModel(
    name: 'South Asian Hospital Ltd',
    address: '69/E, Green Road, Panthpath, Dhaka',
    icon: Icons.call,
    call: 9665852,
  ),
  CallHospitalModel(
    name: 'Square Diagnostic & Hospital',
    address: '19, Green Road Dhaka-1205',
    icon: Icons.call,
    call: 8616389,
  ),
  CallHospitalModel(
    name: 'The Barakah General Hospital Ltd',
    address: '937, Outer Circula Road, Razarbagh',
    icon: Icons.call,
    call: 9337534,
  ),
  CallHospitalModel(
    name: 'The Kidney Hospital And Dialysis Centre',
    address: '161/A, Kalabagan, Dhaka - 1205',
    icon: Icons.call,
    call: 8123056,
  ),
  CallHospitalModel(
    name: 'The Specialized Hospital (Pvt) Ltd',
    address: '19, Green Road Dhaka-1205',
    icon: Icons.call,
    call: 8616389,
  ),
  CallHospitalModel(
    name: 'House # 40, Road # 10/A,Dhanmondi R/A, Dhaka',
    address: '19, Green Road Dhaka-1205',
    icon: Icons.call,
    call: 9118523,
  ),
  CallHospitalModel(
    name: 'Uro Care Medical Center',
    address: 'House # 73, Road # 9/A, Dhanmondi',
    icon: Icons.call,
    call: 9126113,
  ),
  CallHospitalModel(
    name: 'Uttara Central Hospital',
    address: 'House # 1, Road # 7, Sector # 1, Uttara Model Town',
    icon: Icons.call,
    call: 8911551,
  ),
  CallHospitalModel(
    name: "Women And Children's Hospital Pvt.Ltd",
    address: 'House # 48/6, Road # 9/A Dhanmondi, Dhaka',
    icon: Icons.call,
    call: 9121077,
  ),
  CallHospitalModel(
    name: 'Yamagata Dhaka Friendsship Hospital',
    address: '6/7, Block -A Lalmatia Dhaka',
    icon: Icons.call,
    call: 9129354,
  ),
  CallHospitalModel(
    name: "Z.H. Sikder Women's College & Hospital (Pvt) Ltd",
    address: 'Monica Estate, (West side of Dhanmondi)',
    icon: Icons.call,
    call: 8113313,
  ),
];