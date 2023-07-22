import 'package:doczone/models/health_tips_model.dart';
import 'package:doczone/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'homepage.dart';

// Assuming healthTipsList is a List of HealthTip objects

class HealthTips extends StatelessWidget {
  const HealthTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Health Tips',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: healthTipsList.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.5,
                  ),
                  itemBuilder: (context, index) {
                    String playlistUrl;
                    switch (index) {
                      case 0:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UadKtoXAjnbLUejdU7K_QL9';
                        break;
                      case 1:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UYE2CLKIji7pIOsWmKGzs0L';
                        break;
                      case 2:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UYdlvWJpF92YWZSoMhHl1No';
                        break;
                      case 3:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UYUdtk29PN7rwJOWdW62MuI';
                        break;
                      case 4:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UYT_eCDTjy-UYpGoz83Ib6y';
                        break;
                      case 5:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UaFFSq9ob3QVxCOHqoSowmw';
                        break;
                      case 6:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UaA5el10YJk39F-fvdw3IHm';
                        break;
                      case 7:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7Uay8TjUMTb9BNfdQisuegOl';
                        break;
                      case 8:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UZXCHWk01cBUQykF0OIt1oF';
                        break;
                      case 9:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7Ua58wfGAkdH0Ww5G8R6iZch';
                        break;
                      case 10:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7Ua6jqtyls72lmMQUykoI3NQ';
                        break;
                      case 11:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UbeD60L8i2Ed8wb21eu9ohY';
                        break;
                      case 12:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UbaxDS8glXMjRGDHDxl-fG6';
                        break;
                      case 13:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7Ubwe4LwdATzb032E7ItgOH_';
                        break;
                      case 14:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UbW_QKaIj4I_XOItESqfgSv';
                        break;

                      default:
                        playlistUrl =
                        'https://www.youtube.com/playlist?list=PLrqGoP_t_7UYWdEFZqX_Tiu-YkGe3lmPf';
                    }

                    return InkWell(
                      onTap: () async {
                        launchUrlPage(playlistUrl);
                        // ignore: deprecated_member_use
                        // if (await canLaunch(playlistUrl)) {
                        //   // ignore: deprecated_member_use
                        //   await launch(playlistUrl);
                        // }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            '${healthTipsList[index].title}',
                            textAlign: TextAlign.center,
                            style: fontStyle(
                              16,
                              textClrDark,
                              FontWeight.w700,
                            ),
                          ),
                        ),
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
