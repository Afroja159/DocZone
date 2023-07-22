// import 'dart:async';
// import 'dart:html';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:doczone/location/location_permission.dart';
//
//
// class LocationService {
//   var location = Location();
//   LocationService({document, bloodGroup, mobileNo, name}) {
//     location.requestPermission().then((permissionStatus) {
//       if (permissionStatus == PermissionStatus.granted) {
//         location.onLocationChanged.listen((locationData) {
//           addGeoPoint(document: document, bloodGroup: bloodGroup, mobileNo: mobileNo, name: name);
//         });
//       }
//     });
//   }
// }
//
//
// Future<void> addGeoPoint({document, bloodGroup, mobileNo, name}) async {
//
//   //print('&*************************************** : $document');
//
//   determinePosition().then((value) async {
//     double lang = value.latitude;
//     double long = value.longitude;
//     Geoflutterfire geo = Geoflutterfire();
//     GeoFirePoint point = geo.point(latitude: lang, longitude: long);
//
//     GeoCode geoCode = GeoCode();
//     try {
//
//       Address address = await geoCode.reverseGeocoding(latitude: lang, longitude: long);
//
//       // print('city: ${address.city}');
//       // print('countryName: ${address.countryName}');
//       // print('postal: ${address.postal}');
//       // print('streetAddress: ${address.streetAddress}');
//       // print('streetNumber: ${address.streetNumber}');
//       // print('region: ${address.region}');
//
//       return FirebaseFirestore.instance.collection('User_Information').doc('${document ?? document}').set({
//
//         'blood_group'       : bloodGroup,
//         'mobile_no'         : mobileNo,
//         'name'              : name,
//         'city'              : address.city,
//         'country_name'      : address.countryName,
//         'postal_code'       : address.postal,
//         'street_address'    : address.streetAddress,
//         'region'            : address.region,
//         'position'          : point.data,
//         'age'               : '',
//         'gender'            : '',
//         'nid_no'            : '',
//         'marital_status'    : '',
//         'district'          : '',
//         'thana'             : '',
//         'emergency_contact' : '',
//
//       }).then((value) => {
//         //print('user_added '),
//       }).catchError((error) => print("Failed to add user: $error"));
//
//     } catch (e) {
//       print(e);
//     }
//
//
//
//   });
// }