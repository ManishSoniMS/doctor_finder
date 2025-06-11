import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_style.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../authentication/domain/doctor_user.dart';

class DoctorListTileWidget extends StatelessWidget {
  const DoctorListTileWidget({super.key, required this.doctor});

  final DoctorUser doctor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(AppRoute.doctorDetails.name, extra: doctor);
      },
      leading: CircleAvatar(
        radius: 30.rsW,
        child: Image.network(
          doctor.imageUrl ?? '',
          errorBuilder: (context, _, __) => Icon(Icons.error),
        ),
        // backgroundImage: NetworkImage(doctor.imageUrl ?? ''),
      ),
      title: Text(
        doctor.name,
        style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Specialization: ${doctor.specialization ?? 'N/A'}'),
          Row(
            children: [
              Icon(Icons.location_on, size: 20, color: AppStyles.mainColor),
              Expanded(
                child: Text(
                  doctor.location,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Icon(Icons.directions, size: 50, color: AppStyles.mainColor),
    );
  }
}
