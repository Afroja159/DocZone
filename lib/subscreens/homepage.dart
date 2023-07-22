import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/models/home_option_model.dart';
import 'package:doczone/screens/login_page.dart';
import 'package:doczone/subscreens/about_us.dart';
import 'package:doczone/subscreens/blood_center.dart';
import 'package:doczone/subscreens/bmi_calculator.dart';
import 'package:doczone/subscreens/call_hospital.dart';
import 'package:doczone/subscreens/covid_19.dart';
import 'package:doczone/subscreens/health_tips.dart';
import 'package:doczone/subscreens/medi_time.dart';
import 'package:doczone/subscreens/myprofile.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List sliderList = [
    {"id": "1", "image": "assets/slider/1.svg"},
    {"id": "1", "image": "assets/slider/2.svg"},
    {"id": "1", "image": "assets/slider/3.svg"},
    {"id": "1", "image": "assets/slider/4.svg"},
    {"id": "1", "image": "assets/slider/5.svg"},
  ];

  CarouselController carouselController = CarouselController();

  int sliderIndex = 0;

  double fullRating = 0;

  rating() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              'How was your experience ?',
              style: fontStyle(16, Colors.blueGrey, FontWeight.w700),
            ),
          ),
          actions: [
            Center(
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                unratedColor: Colors.grey,
                itemCount: 5,
                itemSize: 35,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                updateOnDrag: true,
                itemBuilder: (context, index) => const Icon(
                  Icons.star_sharp,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  setState(() {
                    fullRating = value;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              height: 55,
              minWidth: double.infinity,
              color: buttonClr,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Submit',
                style: fontStyle(17, textClrELight, FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  docszone() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                InkWell(
                  onTap: () async {
                    launchUrlPage('https://populardiagnostic.com/our-doctors');
                    // const url = 'https://populardiagnostic.com/our-doctors';
                    // // ignore: deprecated_member_use
                    // if (await canLaunch(url)) {
                    //   // ignore: deprecated_member_use
                    //   await launch(url);
                    // } else {
                    //   throw 'Could not launch $url';
                    // }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.person_pin_rounded,
                          color: buttonClr,
                        ),
                      ),
                      Text(
                        'Popular Diagnostic Centre',
                        style: fontStyle(14, textClrDark, FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    launchUrlPage('https://www.ibnsinatrust.com/find_a_doctor.php');
                    // const url = 'https://populardiagnostic.com/our-doctors';
                    // // ignore: deprecated_member_use
                    // if (await canLaunch(url)) {
                    //   // ignore: deprecated_member_use
                    //   await launch(url);
                    // } else {
                    //   throw 'Could not launch $url';
                    // }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.person_pin_rounded,
                          color: buttonClr,
                        ),
                      ),
                      Text(
                        'Ibn Sina Diagnostic Centre',
                        style: fontStyle(14, textClrDark, FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    launchUrlPage('https://labaidgroup.com/specialized/doctor');
                    // const url = 'https://populardiagnostic.com/our-doctors';
                    // // ignore: deprecated_member_use
                    // if (await canLaunch(url)) {
                    //   // ignore: deprecated_member_use
                    //   await launch(url);
                    // } else {
                    //   throw 'Could not launch $url';
                    // }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.person_pin_rounded,
                          color: buttonClr,
                        ),
                      ),
                      Text(
                        'Labaid Diagnostic Centre',
                        style: fontStyle(14, textClrDark, FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    launchUrlPage('https://medinova.com.bd/doctor-details/');
                    // const url = 'https://populardiagnostic.com/our-doctors';
                    // // ignore: deprecated_member_use
                    // if (await canLaunch(url)) {
                    //   // ignore: deprecated_member_use
                    //   await launch(url);
                    // } else {
                    //   throw 'Could not launch $url';
                    // }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.person_pin_rounded,
                          color: buttonClr,
                        ),
                      ),
                      Text(
                        'Medinova Diagnostic Centre',
                        style: fontStyle(14, textClrDark, FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                // InkWell(
                //   onTap: () async {
                //
                //     launchUrlPage('https://populardiagnostic.com/booking/appointment');
                //
                //     // const url =
                //     //     'https://populardiagnostic.com/booking/appointment';
                //     // // ignore: deprecated_member_use
                //     // if (await canLaunch(url)) {
                //     //   // ignore: deprecated_member_use
                //     //   await launch(url);
                //     // } else {
                //     //   throw 'Could not launch $url';
                //     // }
                //     // ignore: use_build_context_synchronously
                //     Navigator.pop(context);
                //   },
                //   child: Row(
                //     children: [
                //       const Padding(
                //         padding: EdgeInsets.all(12),
                //         child: Icon(
                //           Icons.note_alt_rounded,
                //           color: buttonClr,
                //         ),
                //       ),
                //       Text(
                //         'Book an Appointment',
                //         style: fontStyle(14, textClrDark, FontWeight.w600),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  call999() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '999 National Emergency Service',
            style: fontStyle(16, textClrDark, FontWeight.w700),
          ),
          content: Text(
            '999 National Emergency Service is a centralized 24/7 emergency support allowing any citizen within the country border to directly connect with the Police, Fire and Ambulance emergency responding teams on the ground, in order to get aid in an emergency state.',
            style: fontStyle(14),
          ),
          actions: [
            Column(
              children: [
                Text(
                  'Need an Emergency Support ?',
                  style: fontStyle(16, Colors.red, FontWeight.w700),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 18),
                      child: MaterialButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 25),
                        color: buttonClr,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () async {
                          final Uri url = Uri(scheme: 'tel', path: '999');

                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Call 999',
                              style:
                                  fontStyle(16, Colors.white, FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool showBackButton = false;

  toggleBackButton(value) {
    setState(() {
      showBackButton = value;
    });
  }





  String uid = '';
  String firstName = '';
  String fullName = '';
  String mobile = '';
  String lastName = '';
  String address = '';
  String dob = '';
  String gender = '';
  String bloodGroup = '';
  String image = '';
  String deviceToken = '';
  String userCreationTime = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      String uid = AuthService.user!.uid;
      DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('Users').doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        setState(() {
          this.uid = uid;
          fullName = data['fullName'] ?? '';
          firstName = data['firstName'] ?? '';
          mobile = data['mobile'] ?? '';
          lastName = data['lastname'] ?? '';
          address = data['address'] ?? '';
          dob = data['dob'] ?? '';
          gender = data['gender'] ?? '';
          bloodGroup = data['bloodGroup'] ?? '';
          image = data['image'] ?? '';
          deviceToken = data['deviceToken'] ?? '';
          userCreationTime = data['userCreationTime'] ?? '';
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'DocZone',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                accountName: Text(
                  "${AuthService.user!.displayName}",
                  style: fontStyle(18, textClrDark, FontWeight.bold),
                ),
                accountEmail: Text(
                  "${mobile}",
                  style: fontStyle(16, textClrDark, FontWeight.w500),
                ),
                currentAccountPicture:  CircleAvatar(
                  backgroundImage: Image.network(image??"assets/images/bg.png").image,
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  toggleBackButton(true);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyProfile()),
                  );
                },
                leading: const Icon(Icons.edit),
                title: const Text('Edit Profile'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutUs()));
                },
                leading: const Icon(Icons.info_outline),
                title: const Text('About Us'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Share.share('com.doczone');
                },
                leading: const Icon(Icons.share),
                title: const Text('Share'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  rating();
                },
                leading: const Icon(Icons.star),
                title: const Text('Rate Us!'),
              ),
              ListTile(
                onTap: () {
                  AuthService.logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                        (route) => false,
                  );

                },
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 4.5,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello,',
                        style: fontStyle(17, textClrDark, FontWeight.w700),
                      ),
                      Text(
                        "${AuthService.user!.displayName}",
                        style: fontStyle(18, buttonClr, FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
              CarouselSlider(
                items: sliderList
                    .map((item) => SvgPicture.asset(
                          item['image'],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      sliderIndex = index;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeOptionList1.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              childAspectRatio: 2.5),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BMI(),
                                    ));
                                break;
                              default:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HealthTips(),
                                    ));
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: textClrELight,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SvgPicture.asset(
                                      '${homeOptionList1[index].image}'),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    '${homeOptionList1[index].title}',
                                    style: fontStyle(
                                        14, textClrDark, FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      height: 2,
                      color: buttonClr,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: homeOptionList2.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 30,
                              childAspectRatio: 1.1),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            switch (index) {
                              case 0:
                                docszone();
                                break;
                              case 1:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MediTime(),
                                    ));
                                break;
                              case 2:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BloodCenter(),
                                    ));
                                break;
                              case 3:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Covid19(),
                                    ));
                                break;
                              case 4:
                                call999();
                                break;
                              default:
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CallHospital(),
                                    ));
                            }
                          },
                          child: Column(
                            children: [
                              Expanded(
                                flex: 3,
                                child: SvgPicture.asset(
                                    '${homeOptionList2[index].image}'),
                              ),
                              const SizedBox(height: 12),
                              Expanded(
                                child: Text(
                                  '${homeOptionList2[index].title}',
                                  style: fontStyle(
                                      14, textClrDark, FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Future<void> launchUrlPage(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}