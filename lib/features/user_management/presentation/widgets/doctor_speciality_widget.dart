import 'package:doctor_finder/utils/app_style.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/specialization_list.dart';

class DoctorSpecialityWidget extends ConsumerWidget {
  const DoctorSpecialityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfSpecialities = ref.watch(specializationListProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.rsW),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Doctor Speciality',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black),
              ),
              ElevatedButton(onPressed: () {}, child: Text("See all")),
            ],
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...listOfSpecialities.map((speciality) {
                  final icon =
                      specialityIcon[speciality] ?? Icons.question_mark;
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 25.rsW,
                          child: Icon(
                            icon,
                            size: 30,
                            color: AppStyles.mainColor,
                          ),
                        ),
                        SizedBox(height: 10.rsW),
                        Text(
                          speciality,
                          style: AppStyles.normalTextStyle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
