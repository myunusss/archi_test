import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'list_hotes_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Colors
  Color navyBlue = const Color.fromARGB(255, 4, 30, 93);
  Color pink = const Color.fromARGB(255, 182, 33, 137);

  // State
  TextEditingController searchTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  final List<Map<String, dynamic>> hotelList = [
    {
      'name': 'ASTON Tropicana',
      'address': 'Jl. Cihampelas 125-129 Bandung 40131 - Indonesia',
      'start_price': 'IDR 2,543,185',
      'price_description': 'per room per night',
      'image_url':
          'https://www.usatoday.com/gcdn/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg',
      'stars': 5,
    },
    {
      'name': 'favehotel Braga',
      'address': 'Jl. Braga No 99-101 Bandung 40111',
      'start_price': 'IDR 739,200',
      'price_description': 'per room per night',
      'image_url': 'https://www.hotelscombined.com.sg/kimg/94/64/5c935c6f9dd227d1.jpg',
      'stars': 5,
    },
    {
      'name': 'ASTON Tropicana C',
      'address': 'Jl. Cihampelas',
      'start_price': 'IDR 2,000,000',
      'price_description': 'per room per night',
      'image_url':
          'https://www.usatoday.com/gcdn/-mm-/05b227ad5b8ad4e9dcb53af4f31d7fbdb7fa901b/c=0-64-2119-1259/local/-/media/USATODAY/USATODAY/2014/08/13/1407953244000-177513283.jpg',
      'stars': 5,
    },
    {
      'name': 'ASTON Tropicana D',
      'address': 'Jl. Cibaduyut Indah No 12-100 40012',
      'start_price': 'IDR 1,043,185',
      'price_description': 'per room per night',
      'image_url': 'https://www.hotelscombined.com.sg/kimg/94/64/5c935c6f9dd227d1.jpg',
      'stars': 5,
    },
  ];

  bool loading = false;
  void _searchHotels() {
    loading = true;
    setState(() {});
    Timer(const Duration(seconds: 2), () {
      loading = false;
      setState(() {});
    });
  }

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 1));
  void _generateCheckInDateText(DateTimeRange dateTimeRange) {
    final defaultFormat = DateFormat("E, dd MMM yyyy");

    startDate = dateTimeRange.start;
    final startDateFormatted = defaultFormat.format(startDate);
    endDate = dateTimeRange.end;
    final endDateFormatted = defaultFormat.format(endDate);
    final diffDays = endDate.difference(startDate).inDays;
    dateTextController.text = "$startDateFormatted - $endDateFormatted, $diffDays Night(s)";
    _searchHotels();
  }

  @override
  void initState() {
    super.initState();
    searchTextController.text = "Hotels Near Me";
    _generateCheckInDateText(DateTimeRange(start: startDate, end: endDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Book a Room',
          style: TextStyle(
            color: navyBlue,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Search
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: pink,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: searchTextController,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                        suffixIcon: IconButton(
                          onPressed: () {
                            searchTextController.text = "Hotels Near Me";
                            _searchHotels();
                          },
                          icon: Icon(
                            Icons.my_location_outlined,
                            color: pink,
                            size: 28,
                          ),
                        ),
                        labelText: "Where are you going?",
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        // Harusnya pakai debounce
                        if (value.length > 2) {
                          _searchHotels();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: pink,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        // date picker
                        DateTimeRange? selectedDate = await showDateRangePicker(
                          context: context,
                          initialDateRange: DateTimeRange(start: startDate, end: endDate),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                          saveText: 'Done',
                        );

                        if (selectedDate != null) {
                          _generateCheckInDateText(selectedDate);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey.shade200),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Check-in Date',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              dateTextController.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: InkWell(
                onTap: () {
                  _searchHotels();
                },
                borderRadius: BorderRadius.circular(6),
                child: Ink(
                  height: 44,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    color: navyBlue,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, offset: Offset(1, 3), blurRadius: 4.0),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Search',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Text(
                'Last Viewed',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: navyBlue,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: loading
                  ? Container(
                      height: 40,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    )
                  : ListHotelsWidget(
                      data: hotelList,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
