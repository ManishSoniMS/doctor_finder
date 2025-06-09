import 'package:doctor_finder/features/user_management/presentation/widgets/doctor_speciality_widget.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/async_value_widget.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../authentication/domain/app_user.dart';
import '../../data/user_repository.dart';
import '../widgets/nearby_doctor_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final userDataAsyncProvider = ref.watch(
      loadUserInformationProvider(userId),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Finder"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: AsyncValueWidget<AppUser>(
                value: userDataAsyncProvider,
                onData: (user) {
                  return CircleAvatar(
                    backgroundImage: user.imageUrl != null
                        ? NetworkImage(user.imageUrl!)
                        : null,
                    child: user.imageUrl == null
                        ? Icon(Icons.person, size: 20)
                        : null,
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your upcoming bookings",
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),

            Container(
              width: SizeConfig.screenWidth * 0.8,
              height: 100.rsH,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'No upcoming bookings',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            SizedBox(height: 15.rsH),
            DoctorSpecialityWidget(),
            SizedBox(height: 15.rsH),
            NearbyDoctorWidget(),
            SizedBox(height: 15.rsH),
          ],
        ),
      ),
    );
  }
}
