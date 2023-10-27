import 'package:flutter/material.dart';

class StarsWidget extends StatelessWidget {
  final int length;
  const StarsWidget({
    super.key,
    required this.length,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        itemCount: length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(right: 3),
            child: Icon(
              Icons.star,
              size: 14,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
