import 'package:doczone/subscreens/available_donor.dart';
import 'package:doczone/subscreens/requested_blood.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

class BloodBank extends StatefulWidget {
  const BloodBank({super.key});

  @override
  State<BloodBank> createState() => _BloodBankState();
}

class _BloodBankState extends State<BloodBank> {
  int currentIndex = 0;
  PageController? pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: currentIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Blood Bank',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: currentIndex == 0
                      ? MaterialButton(
                          elevation: 0,
                          height: 55,
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              currentIndex = 0;
                              pageController!.jumpToPage(0);
                            });
                          },
                          child: Text(
                            'Available Donor',
                            style: fontStyle(16, buttonClr, FontWeight.bold),
                          ),
                        )
                      : MaterialButton(
                          color: const Color(0xFFDADADA),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15))),
                          elevation: 0,
                          height: 55,
                          onPressed: () {
                            setState(() {
                              currentIndex = 0;
                              pageController!.jumpToPage(0);
                            });
                          },
                          child: Text(
                            'Available Donor',
                            style: fontStyle(16, Colors.grey, FontWeight.bold),
                          ),
                        ),
                ),
                Expanded(
                  flex: 1,
                  child: currentIndex == 1
                      ? MaterialButton(
                          elevation: 0,
                          height: 55,
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              currentIndex = 1;
                              pageController!.jumpToPage(1);
                            });
                          },
                          child: Text(
                            'Requested Blood',
                            style: fontStyle(16, buttonClr, FontWeight.bold),
                          ),
                        )
                      : MaterialButton(
                          color: const Color(0xFFDADADA),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15))),
                          elevation: 0,
                          height: 55,
                          onPressed: () {
                            setState(() {
                              currentIndex = 1;
                              pageController!.jumpToPage(1);
                            });
                          },
                          child: Text(
                            'Requested Blood',
                            style: fontStyle(16, Colors.grey, FontWeight.bold),
                          ),
                        ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: const [
                  AvailableDonor(),
                  RequestedBlood(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
