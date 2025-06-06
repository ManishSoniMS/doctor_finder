import 'dart:io';

import 'package:doctor_finder/utils/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/geocoding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/size_config.dart';
import '../../../../utils/specialization_list.dart';
import '../widgets/common_button.dart';
import '../widgets/common_container.dart';
import '../widgets/common_text_form_field.dart';

class DoctorRegisterScreen extends ConsumerStatefulWidget {
  const DoctorRegisterScreen({super.key});

  @override
  ConsumerState createState() => _DoctorRegisterScreenState();
}

class _DoctorRegisterScreenState extends ConsumerState<DoctorRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _yearsOfExperienceController =
      TextEditingController();

  File? _selectedImage;
  String? _selectedSpecialization;
  double? _latitude;
  double? _longitude;

  final _place = GoogleMapsGeocoding(apiKey: AppKeys.googleAPIKey);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _yearsOfExperienceController.dispose();
    _selectedImage = null;

    super.dispose();
  }

  void _takePicture() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final specializationList = ref.watch(specializationListProvider);
    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(10.rsW, 50.rsH, 10.rsW, 0),
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.rsH),
                  Image.asset(Assets.images.doctorLogo.path, width: 100.rsW),
                  SizedBox(height: 20.rsH),
                  Text(
                    "Doctor Registration",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.rsH),
                  Divider(color: Colors.black, thickness: 2),
                  SizedBox(height: 20.rsH),
                  Text("Tap to add a profile image"),
                  GestureDetector(
                    onTap: _takePicture,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              height: 100.rsW,
                              width: 100.rsW,
                            )
                          : Image.asset(
                              Assets.images.userPlaceholder.path,
                              height: 100.rsW,
                              width: 100.rsW,
                            ),
                    ),
                  ),
                  SizedBox(height: 20.rsH),
                  CommonTextFormField(
                    hintText: "Enter Name...",
                    textInputType: TextInputType.name,
                    controller: _nameController,
                    obscureText: false,
                  ),
                  SizedBox(height: 20.rsH),
                  CommonTextFormField(
                    hintText: "Enter Phone Number...",
                    textInputType: TextInputType.number,
                    controller: _phoneNumberController,
                    obscureText: false,
                  ),
                  SizedBox(height: 20.rsH),
                  CommonTextFormField(
                    hintText: "Enter Your Description...",
                    textInputType: TextInputType.text,
                    controller: _descriptionController,
                    obscureText: false,
                  ),
                  SizedBox(height: 20.rsH),
                  CommonTextFormField(
                    hintText: "Enter Your Years of Experience...",
                    textInputType: TextInputType.datetime,
                    controller: _yearsOfExperienceController,
                    obscureText: false,
                  ),
                  SizedBox(height: 20.rsH),
                  DropdownButtonFormField<String>(
                    value: _selectedSpecialization,
                    items: specializationList
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedSpecialization = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Select Specialization",
                    ),
                  ),
                  SizedBox(height: 20.rsH),
                  CommonTextFormField(
                    hintText: "Enter Email...",
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    obscureText: false,
                  ),
                  SizedBox(height: 20.rsH),
                  CommonTextFormField(
                    hintText: "Enter Password...",
                    textInputType: TextInputType.visiblePassword,
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  SizedBox(height: 20.rsH),
                  GooglePlaceAutoCompleteTextField(
                    textEditingController: _locationController,
                    googleAPIKey: AppKeys.googleAPIKey,
                    debounceTime: 400,
                    isLatLngRequired: true,
                    inputDecoration: InputDecoration(
                      hintText: "Enter Address...",
                    ),
                    itemClick: (prediction) async {
                      setState(() {
                        _locationController.text = prediction.description ?? '';
                      });
                      final details = await _place.searchByPlaceId(
                        prediction.placeId!,
                      );
                      _latitude = details.results.first.geometry.location.lat;
                      _longitude = details.results.first.geometry.location.lng;
                    },
                    itemBuilder: (context, index, prediction) {
                      return ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text(prediction.description ?? ''),
                      );
                    },
                  ),
                  SizedBox(height: 20.rsH),
                  CommonButton(
                    onTap: () {},
                    title: "Register Me",
                    isLoading: false,
                  ),
                  SizedBox(height: 20.rsH),
                  Text(
                    "OR",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.rsH),
                  CommonContainer(
                    onTap: () {
                      context.goNamed(AppRoute.signin.name);
                    },
                    text: "Sign in to my account",
                  ),
                  SizedBox(height: 30.rsH),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
