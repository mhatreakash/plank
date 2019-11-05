import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF58D68D),
        title: Text("About"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Plank",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Text("Version 1.0.0"),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            ),
            Row(
              children: <Widget>[
                Icon(Icons.copyright),
                Expanded(
                    child: Text(" 2019, plank.com, Inc or its affiliates.")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
            ),
            Divider(
              height: 20.0,
              color: Colors.grey,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.topLeft,
              child: Text(
                "About Plank",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "Plank is a furniture shopping portal which helps users buy furniture online.Earlier most of the people used to buy furniture by visiting the shop. It is a verytedious and time-consuming process. Today’s generation want everything online. So, to fulfil the demands of this generation we have developed this project which helps users buy great quality furniture of their favourite brands online."),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.topLeft,
              child: Text(
                "Privacy & Policy",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "E-commerce is the activity of buying or selling of products on online services or over the Internet. Electronic commerce draws on technologies such as mobile commerce, electronic funds transfer, supply chain management, Internet marketing, online transaction processing, electronic data interchange (EDI), inventory management systems, and automated data collection systems."),
            )
          ],
        ),
      ),
    );
  }
}
