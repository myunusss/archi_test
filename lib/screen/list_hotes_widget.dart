import 'package:flutter/material.dart';

import 'stars_widget.dart';

class ListHotelsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const ListHotelsWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    Color navyBlue = const Color.fromARGB(255, 4, 30, 93);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final hotel = data[index];
        return Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 1.0),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: Image.network(
                  hotel['image_url'].toString(),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotel['name'].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: navyBlue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        hotel['address'].toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      StarsWidget(
                        length: int.parse(hotel['stars'].toString()),
                      ),
                      // stars
                      const Spacer(),
                      const Text(
                        'Starts from',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: hotel['start_price'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 213, 4, 150),
                          ),
                          children: [
                            TextSpan(
                              text: " / ${hotel['price_description']}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 14);
      },
    );
  }
}
