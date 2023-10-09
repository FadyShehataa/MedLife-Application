import 'package:flutter/material.dart';
import '../../../Prescription%20OCR/presentation/views/prescription_result_view_body.dart';

class PrescriptionResultView extends StatelessWidget {
  const PrescriptionResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: const PrescriptionResultViewBody(),
          ),
        ),
      ),
    );
  }
}
