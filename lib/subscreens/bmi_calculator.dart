import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BMI extends StatefulWidget {
  const BMI({super.key});

  @override
  State<BMI> createState() => _BMIState();
}

class _BMIState extends State<BMI> {
  bmi() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  result!.toStringAsFixed(2),
                  style: fontStyle(42, Colors.blue, FontWeight.bold),
                ),
                const SizedBox(width: 5),
                Text(
                  'BMI',
                  style:
                      fontStyle(20, const Color(0xFF8B8B8B), FontWeight.bold),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 2,
              color: buttonClr,
            ),
            Align(
              alignment: Alignment.center,
              child: result! < 18.5
                  ? Text('Underweight',
                      style: fontStyle(24, Colors.blue, FontWeight.bold))
                  : result! <= 24.99
                      ? Text('Normal',
                          style: fontStyle(24, Colors.green, FontWeight.bold))
                      : Text('Overweight',
                          style: fontStyle(24, Colors.red, FontWeight.bold)),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 2,
              color: buttonClr,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: MaterialButton(
                height: 45,
                padding: const EdgeInsets.all(12),
                color: buttonClr,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: fontStyle(16, Colors.white, FontWeight.w700),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isMale = false;
  int weight = 55;
  double height = 140;
  int age = 30;
  double? result;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'BMI Calculator',
            style: fontStyle(23, textClrELight, FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: fontStyle(18, textClrDark, FontWeight.bold),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Card(
                          color: isMale == true ? buttonClr : textClrDark,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child:
                                    SvgPicture.asset('assets/icons/male.svg'),
                              ),
                              const SizedBox(height: 7),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                child: Text(
                                  'Male',
                                  style: fontStyle(
                                      16, textClrELight, FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Card(
                          color: isMale == false ? buttonClr : textClrDark,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child:
                                    SvgPicture.asset('assets/icons/female.svg'),
                              ),
                              const SizedBox(height: 7),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                child: Text(
                                  'Female',
                                  style: fontStyle(
                                      16, textClrELight, FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 10),
                  height: 170,
                  decoration: BoxDecoration(
                    color: textClrDark,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Height',
                        style: fontStyle(22, textClrELight, FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              height.toStringAsFixed(0),
                              style:
                                  fontStyle(40, textClrELight, FontWeight.bold),
                            ),
                            Text(
                              'cm',
                              style: fontStyle(16, textClrELight),
                            ),
                          ],
                        ),
                      ),
                      Slider(
                          min: 70,
                          max: 210,
                          activeColor: buttonClr,
                          inactiveColor: textClrLight,
                          value: height,
                          onChanged: (value) {
                            setState(() {
                              height = value;
                            });
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Weight (kg)',
                  style: fontStyle(22, textClrDark, FontWeight.bold),
                ),
                const SizedBox(height: 7),
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: textClrDark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: buttonClr,
                        height: 30,
                        shape: const CircleBorder(),
                        onPressed: () {
                          setState(() {
                            weight--;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.remove,
                            size: 24,
                            color: textClrELight,
                          ),
                        ),
                      ),
                      Text(
                        '$weight',
                        style: fontStyle(24, textClrELight, FontWeight.bold),
                      ),
                      MaterialButton(
                        color: buttonClr,
                        height: 30,
                        shape: const CircleBorder(),
                        onPressed: () {
                          setState(() {
                            weight++;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.add,
                            size: 24,
                            color: textClrELight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  height: 55,
                  minWidth: double.infinity,
                  color: buttonClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: () {
                    // ignore: unused_local_variable
                    result =
                        (weight.toDouble() / (height / 100 * height / 100));
                    bmi();
                  },
                  child: Text(
                    'Calculate',
                    style: fontStyle(16, textClrELight, FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
