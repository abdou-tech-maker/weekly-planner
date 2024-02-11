// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

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
  Future<String> getAndroidVersion() async {
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.release;
  }

  List<String> members = List.filled(30, ''); // Initialize with empty strings

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
              for (var memberIndex = 0;
                  memberIndex < members.length;
                  memberIndex++)
                [
                  if (members[memberIndex].isEmpty)
                    ''
                  else
                    members[memberIndex],
                  for (var dayIndex = 0;
                      dayIndex < daysOfWeek.length;
                      dayIndex++)
                    weeklyPlanning[dayIndex][memberIndex],
                ],
            ],
            headerDecoration: const pw.BoxDecoration(
              color: PdfColors.amber400,
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
    String androidVersion = await getAndroidVersion();
    if (androidVersion.startsWith('10')) {
      final Directory? externalDir = await getExternalStorageDirectory();

      if (externalDir == null) {
        log('External storage directory not available');
        return;
      }
      log("$externalDir");
      if (!await Permission.storage.request().isGranted) {
        log('Permission denied');
        return;
      }

      final String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      String pdfFileName = 'planning_$timeStamp.pdf';

      final String pdfFilePath = '${externalDir.path}/$pdfFileName';

      final File pdfFile = File(pdfFilePath);
      final Uint8List pdfBytes = await pdf.save();
      await pdfFile.writeAsBytes(pdfBytes);
      log('PDF generated at using android 10: $pdfFilePath');
    } else {
      const String documentsDirectoryPath =
          '/storage/emulated/0/Documents'; // Documents directory path
      final String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      String pdfFileName = 'planning_$timeStamp.pdf';

      final String pdfFilePath = '$documentsDirectoryPath/$pdfFileName';

      final File pdfFile = File(pdfFilePath);
      final Uint8List pdfBytes = await pdf.save();
      await pdfFile.writeAsBytes(pdfBytes);
      log('PDF generated at using android above 10 or diferrent then 10: $pdfFilePath');
    }
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
                  generatePdf();
                  showErrorSnackBar(
                      context,
                      "The PDF has been generated successfully.",
                      greenColor,
                      greenColor);
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
