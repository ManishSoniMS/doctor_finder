import 'package:doctor_finder/features/doctor/presentation/widgets/search_bar_widget.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:doctor_finder/utils/specialization_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/app_style.dart';

class DoctorScreen extends ConsumerWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctors')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: SearchBarWidget()),
              ElevatedButton(onPressed: () {}, child: Text("See all")),
              SizedBox(width: 10),
            ],
          ),
          DoctorSpecializationWidget(),
        ],
      ),
    );
  }
}

class DoctorSpecializationWidget extends ConsumerWidget {
  const DoctorSpecializationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfSpecializations = ref.watch(specializationListProvider);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...listOfSpecializations.map((speciality) {
            final icon = specialityIcon[speciality] ?? Icons.question_mark;
            return Container(
              height: 60.rsW,
              width: 60.rsW,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppStyles.mainColor.withAlpha(50),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 30, color: AppStyles.mainColor),
            );
          }),
        ],
      ),
    );
  }
}
