import 'package:flutter/material.dart';

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

  List<String> members = ['Member 1', 'Member 2', 'Member 3', 'Member 4'];

  List<List<String>> weeklyPlanning = List.generate(
    6, // Number of days (columns)
    (index) => List.generate(
      4, // Number of members (rows)
      (index) => '', // Initial value for each cell
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: const MyHeader(
        title: 'Weekly Planing',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataRowMinHeight: 50,
            dataRowMaxHeight: 60,
            columns: [
              const DataColumn(label: Text('Server | Days')),
              for (var member in members) DataColumn(label: Text(member)),
            ],
            rows: List.generate(
              members.length,
              (dayIndex) => DataRow(
                cells: [
                  DataCell(Text(members[dayIndex])),
                  for (var memberIndex in members.asMap().keys)
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
      ),
    );
  }
}
