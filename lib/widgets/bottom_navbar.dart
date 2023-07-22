import 'package:doczone/subscreens/homepage.dart';
import 'package:doczone/subscreens/mynotification.dart';
import 'package:doczone/subscreens/myprofile.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';




enum NavigationBarItem {
  NotificationPage,
  HomePage,
  MyProfile,
}
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Widget> pages = [
     NotificationPage(),
    const HomePage(),
    const MyProfile(),
  ];
  int currentIndex = 1;
  int index = 1;

  int _currentIndex = NavigationBarItem.HomePage.index;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildPageContent(),
      ),
      // bottomNavigationBar: Container(
      //   color: buttonClr,
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      //     child: GNav(
      //       onTabChange: (value) {
      //         setState(() {
      //           currentIndex = value;
      //         });
      //       },
      //       backgroundColor: buttonClr,
      //       color: Colors.white,
      //       activeColor: Colors.white,
      //       tabBackgroundColor: const Color(0x50DF2E2E),
      //       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      //       gap: 8,
      //       tabs: const [
      //         GButton(
      //           icon: Icons.notifications,
      //           text: 'Notification',
      //         ),
      //         GButton(
      //           icon: Icons.home,
      //           text: 'Home',
      //         ),
      //         GButton(
      //           icon: Icons.person,
      //           text: 'Profile',
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor:  Colors.white,
        unselectedItemColor:  Colors.white,
        onTap: _onItemTapped,
              backgroundColor: buttonClr,

        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                  color:  _currentIndex ==0?  Color(0x50DF2E2E):buttonClr,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Icon(Icons.notifications),
                    _currentIndex ==0?  Text("Notification",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w700),):SizedBox(),
                  ],),
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:
            Container(
              decoration: BoxDecoration(
                color:  _currentIndex ==1?  Color(0x50DF2E2E):buttonClr,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.home),
                    _currentIndex ==1?  Text("Home",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w700),):SizedBox(),
                  ],),
              ),
            ),

            label: '',
          ),
          BottomNavigationBarItem(
            icon:
            Container(
              decoration: BoxDecoration(
                color:  _currentIndex ==2?  Color(0x50DF2E2E):buttonClr,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.person),
                    _currentIndex ==2?  Text("Profile",style: TextStyle(color:Colors.white,fontWeight: FontWeight.w700),):SizedBox(),
                  ],),
              ),
            ),

            label: '',
          ),
        ],
      ),
    );
  }
  Widget _buildPageContent() {
    switch (_currentIndex) {
      case 0:
        return NotificationPage();
      case 1:
        return HomePage();
      case 2:
        return MyProfile();
      default:
        return Container();
    }
  }
}
