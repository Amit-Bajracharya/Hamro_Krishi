import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/features/introduction_screen/domain/introduction_screen_model.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<IntroductionContent> _contents = [
    IntroductionContent(
      title: "Connect to the Roots",
      description: "Empowering Nepal's farmers by connecting them directly with middlemen and customers.",
      imagePath: "assets/images/onboarding_1.webp",
    ),
    IntroductionContent(
      title: "Secure Your Harvest",
      description: "Sign smart contracts with partners for weeks or months, ensuring stable income and reliable supply. Transition from volatility to predictable growth.",
      imagePath: "assets/images/onboarding_2.webp",
      badgeText: "VERIFIED SECURE",
    ),
    IntroductionContent(
      title: "Fair Prices, Always",
      description: "Real-time transparency on buying and selling prices so you always know you're getting a fair deal.",
      imagePath: "assets/images/onboarding_3.webp",
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _contents.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return _buildPage(_contents[index]);
                },
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        children: [
          Image.asset(
            'assets/logo/app.png',
            height: 32.h,
          ),
          SizedBox(width: 8.w),
          Text(
            'Hamro Krishi',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B3A1A),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              context.go(AppRoutes.login);
            },
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(IntroductionContent content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    content.imagePath,
                    fit: BoxFit.cover,
                  ),
                  if (content.badgeText != null)
                    Positioned(
                      top: 16.h,
                      left: 16.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.verified, color: const Color(0xFF2D5A27), size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              content.badgeText!,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
          Text(
            content.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp, // Specification from user
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1B3A1A),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              content.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _contents.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 8.h,
                width: _currentIndex == index ? 24.w : 8.w,
                decoration: BoxDecoration(
                  color: _currentIndex == index 
                      ? const Color(0xFF2D5A27) 
                      : const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 48.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                if (_currentIndex < _contents.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                } else {
                  context.go(AppRoutes.login);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D5A27),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    _currentIndex == _contents.length - 1 ? "Get Started" : "Next",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward, size: 20.sp),
                ],
              ),
            ),
          ),
          if (_currentIndex == _contents.length - 1) ...[
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () {
                context.go(AppRoutes.login);
              },
              child: Text(
                'Skip to Market',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF1B3A1A),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
