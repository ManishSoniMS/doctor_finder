import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/app_style.dart';
import '../../../../utils/specialization_list.dart';
import '../../../user_management/presentation/providers/specialization_provider.dart';

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
            return InkWell(
              onTap: () {
                ref
                    .read(specializationNotifierProvider.notifier)
                    .setSpecialization(speciality);
              },
              child: Container(
                height: 60.rsW,
                width: 60.rsW,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppStyles.mainColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 30, color: AppStyles.mainColor),
              ),
            );
          }),
        ],
      ),
    );
  }
}
