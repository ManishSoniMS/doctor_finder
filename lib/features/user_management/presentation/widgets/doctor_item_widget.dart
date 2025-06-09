import 'package:doctor_finder/features/user_management/presentation/widgets/rating_stars.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widget/async_value_widget.dart';
import '../../../../utils/app_style.dart';
import '../../../authentication/data/auth_repository.dart';
import '../../../authentication/domain/doctor_user.dart';
import '../../data/user_repository.dart';
import 'calculate_distance.dart';

class DoctorItemWidget extends ConsumerWidget {
  const DoctorItemWidget(this.doctor, {super.key});

  final DoctorUser doctor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final userDataAsync = ref.watch(loadUserInformationProvider(userId));
    return AsyncValueWidget(
      value: userDataAsync,
      onData: (userData) {
        final distance = calculateDistance(
          userData.latitude,
          userData.longitude,
          doctor.latitude,
          doctor.longitude,
        );
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 7,
                spreadRadius: 2,
                offset: Offset(3, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  doctor.imageUrl ?? '',
                  height: 120.rsW,
                  width: 120.rsW,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(Icons.person, size: 50),
                ),
              ),
              Text(
                doctor.name,
                style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
              ),
              Text(
                doctor.specialization ?? 'Specialization not available',
                style: AppStyles.normalTextStyle.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                children: [
                  RatingStars(rating: 5),
                  SizedBox(width: 10),
                  Text('(100)'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.social_distance),
                  SizedBox(width: 10),
                  Text('$distance away'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
