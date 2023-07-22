import 'package:doczone/subscreens/countries_list_screen.dart';
import 'package:doczone/subscreens/worldStates_model.dart';
import 'package:doczone/subscreens/world_states_view_model.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates> {
  WorldStatesViewModel newsListViewModel = WorldStatesViewModel();

  var colorList = <Color>[
    // ignore: use_full_hex_values_for_flutter_colors
    const Color(0xffb12441e2),
    const Color(0xff7FB77E),
    // ignore: use_full_hex_values_for_flutter_colors
    const Color(0xffc5f00b0b),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Covid-19 Updates", style: fontStyle(23, textClrELight, FontWeight.w700),),
          centerTitle: true,),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              children: [
                FutureBuilder<WorldStatesModel>(
                    future: WorldStatesViewModel().fetchWorldRecords(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error fetching data'),
                        );
                      } else {
                        var dataMap = {
                          "Total": double.parse(snapshot.data!.cases.toString()),
                          "Recovered":
                              double.parse(snapshot.data!.recovered.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths.toString()),
                        };
                        return Column(
                          children: [
                            PieChart(
                              dataMap: dataMap,
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              chartLegendSpacing: 32,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              colorList: const [
                                // ignore: use_full_hex_values_for_flutter_colors
                                Color(0xffb12441e2),
                                Color(0xff7FB77E),
                                // ignore: use_full_hex_values_for_flutter_colors
                                Color(0xffc5f00b0b),
                              ],
                              initialAngleInDegree: 0,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 25,
                              legendOptions: const LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.left,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: true,
                                decimalPlaces: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: 'Total Cases',
                                        value: snapshot.data!.cases.toString()),
                                    ReusableRow(
                                        title: 'Deaths',
                                        value: snapshot.data!.deaths.toString()),
                                    ReusableRow(
                                        title: 'Recovered',
                                        value:
                                            snapshot.data!.recovered.toString()),
                                    ReusableRow(
                                        title: 'Active',
                                        value: snapshot.data!.active.toString()),
                                    ReusableRow(
                                        title: 'Critical',
                                        value:
                                            snapshot.data!.critical.toString()),
                                    ReusableRow(
                                        title: 'Today Deaths',
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    ReusableRow(
                                        title: 'Today Recovered',
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CountriesListScreen()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: buttonClr,
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: Text(
                                    'Track Countries',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}
