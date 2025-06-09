import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/geocoding.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/app_style.dart';
import '../../../../utils/keys.dart';
import '../controller/auth_controller.dart';
import '../widgets/common_button.dart';
import '../widgets/common_container.dart';
import '../widgets/common_text_form_field.dart';
import '/features/authentication/presentation/widgets/async_value_ui.dart';
import '/utils/size_config.dart';

class UserRegisterScreen extends ConsumerStatefulWidget {
  const UserRegisterScreen({super.key});

  @override
  ConsumerState createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends ConsumerState<UserRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  File? _selectedImage;
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
    final authController = ref.watch(authControllerProvider);

    ref.listen(authControllerProvider, (p, c) {
      c.showAlertDialogOnError(context);
    });

    return Scaffold(
      backgroundColor: AppStyles.mainColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.rsW, 50.rsH, 10.rsW, 0),
          child: SingleChildScrollView(
            child: Container(
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
                    "User Registration",
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
                    onTap: () {
                      ref
                          .read(authControllerProvider.notifier)
                          .createUserWithEmailAndPassword(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            name: _nameController.text.trim(),
                            phoneNumber: _phoneNumberController.text.trim(),
                            imageUrl: _selectedImage,
                            location: _locationController.text.trim(),
                            latitude: _latitude,
                            longitude: _longitude,
                            type: "user",
                          );
                    },
                    title: "Register Me",
                    isLoading: authController.isLoading,
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
          ),
        ),
      ),
    );
  }
}
