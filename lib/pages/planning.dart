// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constantes/constantes.dart';
import '../widgets/appHeader.dart';

class Planing extends StatefulWidget {
  const Planing({Key? key}) : super(key: key);

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

  List<String> members = List.generate(30, (index) => 'Member ${index + 1}');

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

  Future<void> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Table.fromTextArray(
            context: context,
            data: [
              ['Server \\ Days', ...daysOfWeek],
              for (var memberIndex = 0;
                  memberIndex < members.length;
                  memberIndex++)
                [
                  members[memberIndex],
                  for (var dayIndex = 0;
                      dayIndex < daysOfWeek.length;
                      dayIndex++)
                    weeklyPlanning[dayIndex][memberIndex],
                ],
            ],
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.grey300,
            ),
            rowDecoration: const pw.BoxDecoration(
              border: pw.Border(),
            ),
            headers: List<String>.generate(daysOfWeek.length + 1, (index) {
              if (index == 0) {
                return 'Server \\ Days';
              } else {
                return daysOfWeek[index - 1];
              }
            }),
          ),
        ],
      ),
    );

    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}/weekly_planning.pdf';

    final File file = File(path);
    final Uint8List pdfBytes = await pdf.save();
    await file.writeAsBytes(pdfBytes);

    log('PDF generated at: $path');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      appBar: const MyHeader(
        title: 'Weekly Planning',
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
                      ),
                    ),
                  ),
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
                  generatePdf(); // Call the function to generate PDF
                  // You can add your logic here
                },
                child: const Text('Generate PDF'),
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
