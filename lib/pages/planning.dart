import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constantes/constantes.dart';
import '../widgets/appHeader.dart';

class Planing extends StatefulWidget {
  const Planing({super.key});

  @override
  State<Planing> createState() => _PlaningState();
}

class _PlaningState extends State<Planing> {
  List<String> daysOfWeek = [
    'samedi',
    'dimanche',
    'mardi',
    'mercredi',
    'jeudi',
    'vendredi'
  ];

  List<String> members = List.generate(10, (index) => 'Member ${index + 1}');

  List<List<String>> weeklyPlanning = [];

  @override
  void initState() {
    super.initState();

    weeklyPlanning = List.generate(
      6, // Number of days (columns)
      (index) => List.generate(
        members.length, // Number of members (rows)
        (index) => '', // Initial value for each cell
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: const MyHeader(
        title: 'Weekly Planing',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(2),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowMinHeight: 50,
                dataRowMaxHeight: 60,
                columns: [
                  DataColumn(
                      label: SizedBox(
                          child: Text(
                    'Server \\ Days',
                    style: GoogleFonts.poppins(
                        color: blackText,
                        height: 0,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  ))),
                  for (var day in daysOfWeek)
                    DataColumn(label: Text(day, style: simple)),
                ],
                rows: List.generate(
                  members.length, // Rows for each member
                  (memberIndex) => DataRow(
                    cells: [
                      DataCell(
                        TextFormField(
                          initialValue: '',
                          onChanged: (value) {
                            setState(() {
                              members[memberIndex] = value;
                            });
                          },
                        ),
                      ),
                      for (var dayIndex in daysOfWeek.asMap().keys)
                        DataCell(
                          TextFormField(
                            initialValue: weeklyPlanning[dayIndex][memberIndex],
                            onChanged: (value) {
                              setState(() {
                                weeklyPlanning[dayIndex][memberIndex] = value;
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0, // Adjust the height as needed
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                ),
                onPressed: () {
                  // Handle button press
                  // You can add your logic here
                },
                child: const Text('Your Button'),
              ),
            ),
            const SizedBox(
              height: 20.0, // Adjust the height as needed
            ),
          ],
        ),
      ),
    );
  }
}
