import 'package:doctor_finder/routes/routes.dart';
import 'package:doctor_finder/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome to Doctor Finder",
      "description": "Find the best doctors near you with ease.",
      "image": "assets/images/onboarding1.png",
    },
    {
      "title": "Book Appointments",
      "description": "Schedule your appointments in just a few taps.",
      "image": "assets/images/onboarding2.png",
    },
    {
      "title": "Get Reminders",
      "description": "Never miss an appointment with our reminder system.",
      "image": "assets/images/onboarding3.png",
    },
  ];

  void _onNext(int index) {
    setState(() {
      _currentPage = index;
    });

    _pageController.animateToPage(
      _currentPage,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onSkip() {
    completeOnboarding();
  }

  void completeOnboarding() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('hasSeenOnboarding', true);
    context.pushReplacementNamed(AppRoute.signin.name);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: _onboardingData.length,
              onPageChanged: _onNext,
              itemBuilder: (context, index) {
                final item = _onboardingData[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      item['image'] ?? '',
                      height: 250,
                      errorBuilder: (context, _, __) => Icon(Icons.error),
                    ),
                    SizedBox(height: 20),
                    Text(
                      item['title'] ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        item['description'] ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              top: 0,
              right: 10,
              child: TextButton(onPressed: _onSkip, child: Text("Skip")),
            ),

            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_onboardingData.length, (index) {
                  bool isSelected = index == _currentPage;
                  return AnimatedContainer(
                    margin: EdgeInsets.all(5),
                    duration: Duration(milliseconds: 300),
                    width: isSelected ? 12 : 8,
                    height: isSelected ? 12 : 8,
                    decoration: BoxDecoration(
                      color: isSelected ? AppStyles.mainColor : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
