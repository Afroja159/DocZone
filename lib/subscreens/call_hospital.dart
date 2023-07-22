import 'package:doczone/models/call_hospital_model.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:doczone/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CallHospital extends StatefulWidget {
  const CallHospital({Key? key}) : super(key: key);

  @override
  State<CallHospital> createState() => _CallHospitalState();
}

class _CallHospitalState extends State<CallHospital> {
  List<CallHospitalModel> foundHospitalList = [];

  @override
  void initState() {
    foundHospitalList = allHospitalList;
    super.initState();
  }

  void runFilter(String enteredKeyword) {
    List<CallHospitalModel> searchResult = [];
    if (enteredKeyword.isEmpty) {
      searchResult = allHospitalList;
    } else {
      searchResult = allHospitalList
          .where((hospital) => hospital.name!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundHospitalList = searchResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Call Hospital',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 20, top: 30),
                color: Colors.white,
                child: TextField(
                  onChanged: (value) {
                    runFilter(value);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    suffixIcon: const Icon(Icons.search),
                    suffixIconColor: buttonClr,
                    hintText: 'Search Hospital',
                    labelText: 'Search Hospital',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: buttonClr),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: buttonClr),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.redAccent),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.redAccent),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: foundHospitalList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: ExpansionTile(
                        collapsedBackgroundColor: textClrELight,
                        childrenPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                        title: Text(
                          '${foundHospitalList[index].name}',
                          style: fontStyle(16, buttonClr, FontWeight.w600),
                        ),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Address  :    ',
                                style:
                                    fontStyle(16, buttonClr, FontWeight.w600),
                              ),
                              Expanded(
                                flex: 7,
                                child: Text(
                                  '${foundHospitalList[index].address}',
                                  style: fontStyle(
                                      15, textClrDark, FontWeight.w500),
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri(
                                        scheme: 'tel',
                                        path:
                                            '${foundHospitalList[index].call}');

                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    }
                                  },
                                  icon: Icon(
                                    foundHospitalList[index].icon,
                                    color: buttonClr,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
