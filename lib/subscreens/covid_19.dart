import 'package:doczone/subscreens/covid_splash_screen.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:doczone/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Covid19 extends StatefulWidget {
  const Covid19({super.key});

  @override
  State<Covid19> createState() => _Covid19State();
}

class _Covid19State extends State<Covid19> {
  launchURL(String url) async {
    Uri uri = Uri(scheme: 'https', host: url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw 'Can not launch URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(

          title: Text(
            'Covid-19',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CovidSplashScreen(),
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 23),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/chart.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    'Ratio wise Chart',
                    textAlign: TextAlign.center,
                    style: fontStyle(34, textClrELight, FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  launchUrl(Uri.https('surokkha.gov.bd'));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 45),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/surokkha.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  launchUrl(Uri.https('covid19reports.dghs.gov.bd'));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/covidTest.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    'Covid-19\nTest Report',
                    textAlign: TextAlign.center,
                    style: fontStyle(24, textClrDark, FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
