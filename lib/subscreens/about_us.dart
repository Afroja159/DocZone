import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(

        title: Text(
          'About Us',
          style: fontStyle(23, textClrELight, FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Text("Information can save a life. Yes, this is true in the medical field. A single piece of information can be vital for a patient or for doctors and nurses also. It is important to place the information into the right hands. This work can be done by a health information system with a lot of other significant facilities. It has the potential to greatly enhance user experience and healthcare administration. Following features are in the app: \n\n 1. Blood Center \n 2. Medi Time \n 3.Call Hospital \n 4.Doctors Zone \n 5.Covid - 19 \n 6.National Emergency Service 999 \n 7.BMI \n 8.Health Tips"
              ,style: fontStyle(16, textClrDark) ,
            textAlign: TextAlign.justify ,

    ),
        ),
      ),

    ),
    );
  }
}
