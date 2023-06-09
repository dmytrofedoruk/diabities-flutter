import 'package:flutter/material.dart';

class ItemPointsWidget extends StatelessWidget {
  final String? title;
  final String? value;
  final String? unit;

  const ItemPointsWidget({super.key, required this.title, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, bottom: 10),
      height: 100,
      width: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(46, 120, 184, 1),
              Color.fromRGBO(35, 60, 133, 1),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Text(
            title ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            unit ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ),
    );
  }
}
