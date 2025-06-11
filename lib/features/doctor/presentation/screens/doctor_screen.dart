import 'package:doctor_finder/features/authentication/presentation/widgets/async_value_ui.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/async_value_widget.dart';
import '../../../user_management/data/user_repository.dart';
import '../../../user_management/presentation/providers/specialization_provider.dart';
import '../widgets/doctor_list_tile_widget.dart';
import '../widgets/doctor_specialization_widget.dart';
import '../widgets/search_bar_widget.dart';

class DoctorScreen extends ConsumerWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final specialization = ref.watch(specializationNotifierProvider);
    final doctorsAsyncValue = ref.watch(loadDoctorProvider(specialization));

    ref.listen(
      loadDoctorProvider(specialization),
      (_, state) => state.showAlertDialogOnError(context),
    );
    return Scaffold(
      appBar: AppBar(title: Text('Doctors')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: SearchBarWidget()),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(specializationNotifierProvider.notifier)
                      .setSpecialization('');
                },
                child: Text("See all"),
              ),
              SizedBox(width: 10),
            ],
          ),
          DoctorSpecializationWidget(),
          SizedBox(height: 10.rsH),
          AsyncValueWidget(
            value: doctorsAsyncValue,
            onData: (doctors) {
              if (doctors.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'No doctors found',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: doctors.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorListTileWidget(doctor: doctor);
                },
              );
            },
          ),
          SizedBox(height: 10.rsH),
        ],
      ),
    );
  }
}
