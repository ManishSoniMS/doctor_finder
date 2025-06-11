import 'package:doctor_finder/features/authentication/data/auth_repository.dart';
import 'package:doctor_finder/features/authentication/domain/doctor_user.dart';
import 'package:doctor_finder/features/authentication/presentation/widgets/async_value_ui.dart';
import 'package:doctor_finder/common_widget/common_button.dart';
import 'package:doctor_finder/features/bookings/presentation/controller/booking_controller.dart';
import 'package:doctor_finder/features/user_management/presentation/widgets/rating_stars.dart';
import 'package:doctor_finder/utils/app_style.dart';
import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../bookings/domain/booking.dart';

class DoctorDetailScreen extends ConsumerStatefulWidget {
  const DoctorDetailScreen(this.doctor, {super.key});

  final DoctorUser doctor;

  @override
  ConsumerState createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends ConsumerState<DoctorDetailScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String? get formattedDate {
    if (_selectedDate == null) return null;
    return DateFormat.yMMMEd().format(_selectedDate!);
  }

  void _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = firstDate.add(Duration(days: 30));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  String? get formattedTime {
    if (_selectedTime == null) return null;

    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );
    return DateFormat.jm().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserProvider)!.uid;
    final state = ref.watch(bookingControllerProvider);

    ref.listen(bookingControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.doctor.name}')),
      body: ListView(
        padding: EdgeInsets.all(8.rsW),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              widget.doctor.imageUrl ?? '',
              height: SizeConfig.screenHeight * 0.5,
              width: SizeConfig.screenWidth,
              fit: BoxFit.cover,
              errorBuilder: (context, _, _) => Icon(Icons.error),
            ),
          ),

          Text(
            widget.doctor.name,
            style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
          ),
          Text(
            'Specialization: ${widget.doctor.specialization ?? 'N/A'}',
            style: AppStyles.normalTextStyle.copyWith(color: Colors.black),
          ),
          Row(
            children: [
              Icon(Icons.location_on, color: AppStyles.mainColor, size: 25),
              SizedBox(width: 5),
              Expanded(
                child: Text(
                  widget.doctor.location,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              RatingStars(rating: widget.doctor.rating),
              SizedBox(width: 5),
              Text('(${widget.doctor.rating})'),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(widget.doctor.phoneNumber),
                icon: Icon(Icons.call),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text('Message'),
                icon: Icon(Icons.message),
              ),
            ],
          ),
          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 220.rsH,
                width: 100.rsW,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people, size: 50, color: AppStyles.mainColor),
                    Text("Patients"),
                    Text(widget.doctor.numberOfPatients.toString()),
                  ],
                ),
              ),
              Container(
                height: 220.rsH,
                width: 100.rsW,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.timelapse_outlined,
                      size: 50,
                      color: AppStyles.mainColor,
                    ),
                    Text("Experience"),
                    Text("${widget.doctor.yearsOfExperience} years"),
                  ],
                ),
              ),
              Container(
                height: 220.rsH,
                width: 100.rsW,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.reviews, size: 50, color: AppStyles.mainColor),
                    Text("Reviews"),
                    Text(widget.doctor.numberOfReviews.toString()),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'About',
            style: AppStyles.titleTextStyle.copyWith(color: Colors.black),
          ),
          Text(widget.doctor.description ?? 'No description available'),
          SizedBox(height: 10),
          Text(
            'Day',
            style: AppStyles.normalTextStyle.copyWith(color: Colors.black),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 40,
                  color: AppStyles.mainColor,
                ),
                SizedBox(width: 30),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text(formattedDate ?? 'Tap to select date'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Icon(Icons.access_time, size: 40, color: AppStyles.mainColor),
                SizedBox(width: 30),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _pickTime(context),
                    child: Text(formattedTime ?? 'Tap to select time'),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),
          Expanded(
            child: CommonButton(
              onTap: () async {
                final booking = Booking(
                  userId: userId,
                  doctorId: widget.doctor.userId,
                  date: formattedDate!,
                  time: formattedTime!,
                  service: widget.doctor.specialization!,
                );
                final result = await ref
                    .read(bookingControllerProvider.notifier)
                    .saveBooking(booking: booking);

                if (result) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          'Appointment booked successfully.',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        icon: Icon(
                          Icons.check_circle,
                          color: Colors.grey,
                          size: 120,
                        ),
                        alignment: Alignment.center,
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Okay'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              title: "Book Appointment",
              isLoading: state.isLoading,
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
