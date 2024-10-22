import 'package:ff/model/class.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final List<Homec> _home = [
    Homec("Hayvanlar", "Animals", "assets/animals.png", "/animals"),
    Homec("Meyveler", "Fruits", "assets/fruits.png", "/fruits"),
    Homec("Sebzeler", "Vegetables", "assets/vegetables.png", "/numbers"),
    Homec("Şekiller", "Shapes", "assets/shapes.png", "/numbers"),
    Homec("Renkler", "Colors", "assets/colors.png", "/numbers"),
    Homec("Sayılar", "Numbers", "assets/numbers.png", "/numbers"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          itemCount: _home.length,
          itemBuilder: hlistol,
        ),
      ),
    );
  }

  void _buttonpushed(BuildContext context, int indeks) {
    String route = _home[indeks].h_pageroute;
    Navigator.pushNamed(context, route);
  }

  Widget hlistol(BuildContext context, int indeks) {
    double w = MediaQuery.sizeOf(context).width;
    double h = MediaQuery.sizeOf(context).height;
    return InkWell(
      onTap: () => _buttonpushed(context, indeks),
      child: Card(
        color: const Color.fromARGB(255, 206, 80, 245),
        child: ListTile(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _home[indeks].h_name_tr,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _home[indeks].h_name_en,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Image.asset(
                _home[indeks].h_imagePath,
                width: w * 0.2,
                height: h * 0.13,
                alignment: Alignment.center,
              ),
              //  Row(
              //   children: [
              //     ElevatedButton(
              //       child: Text("f"),
              //        onPressed: () {
              //          //playAudio(_object[indeks].audioPath_tr);
              //         _buttonpushed(context, indeks);
              //       },
              //       style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.grey,
              //         elevation: 0,
              //         padding: EdgeInsetsDirectional.all(1),
              //       ),
              //                           ),
              //    ],
              //  ),
            ],
          ),
        ),
      ),
    );
  }
}
