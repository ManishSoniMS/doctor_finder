import 'package:doctor_finder/features/authentication/presentation/widgets/async_value_ui.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/async_value_widget.dart';
import '../../../authentication/domain/doctor_user.dart';
import '../../data/user_repository.dart';
import '../providers/current_tab_notifier.dart';
import 'doctor_item_widget.dart';

class NearbyDoctorWidget extends ConsumerWidget {
  const NearbyDoctorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(loadDoctorProvider(''), (_, state) {
      state.showAlertDialogOnError(context);
    });

    final listOfDoctorsAsync = ref.watch(loadDoctorProvider(''));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.rsW),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Doctor',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.black),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(currentTabNotifierProvider.notifier).setTab(1);
                },

                child: Text("See all"),
              ),
            ],
          ),

          SizedBox(height: 10.rsW),
          AsyncValueWidget<List<DoctorUser>>(
            value: listOfDoctorsAsync,
            onData: (doctors) {
              if (doctors.isEmpty) {
                return SizedBox(
                  child: Center(
                    child: Text(
                      "No doctors found nearby",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...doctors.map((doc) {
                      return DoctorItemWidget(doc);
                    }),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
