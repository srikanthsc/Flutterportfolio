import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'package:my_portfolio/globals/app_assets.dart';
import 'package:my_portfolio/helper%20class/helper_class.dart';
import '../globals/app_colors.dart';
import '../globals/app_text_styles.dart';
import '../globals/constants.dart';

class MyPortfolio extends StatefulWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  final onHoverEffect = Matrix4.identity()..scale(1.0);

  List<String> projectNames = [
    'Portfolio in Angular',
    'Portfolio in React.js',
    'Portfolio in Vue.js',
    'Portfolio in Ember.js',
    'Portfolio in Next.js',
    'Portfolio in SAPUI5',
  ];

  List<String> images = [
    'assets/images/angular.png',
    'assets/images/react.jpeg',
    'assets/images/vue.png',
    'assets/images/ember.png',
    'assets/images/nextjs.png',
    'assets/images/sapui5.jpeg',
  ];

  List<String> projectDescriptions = [
    'Description for Portfolio in Angular.',
    'Description for Portfolio in React.js.',
    'Description for Portfolio in Vue.js.',
    'Description for Portfolio in Ember.js.',
    'Description for Portfolio in Next.js.',
    'Description for Portfolio in SAPUI5.',
  ];

  List<String> projectUrls = [
    'https://srikanthsc.github.io/srikanthsc.angularportfolio/',
    'https://srikanthsc.github.io/srikanthsc.reactportfolio/',
    'https://srikanthsc.github.io/srikanthsc.vuejsportfolio2/',
    'https://srikanthsc.github.io/emberjsportfolio/',
    'https://srikanthsc.github.io/nextjsportfolio/',
    'https://srikanthsc.github.io/sap.uxap.sample.ProfileObjectPageHeader/',
  ];

  var hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 1),
        ],
      ),
      tablet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 2),
        ],
      ),
      desktop: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 3),
        ],
      ),
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.bgColor,
    );
  }

  GridView buildProjectGridView({required int crossAxisCount}) {
    return GridView.builder(
      itemCount: images.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 280,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        var image = images[index];
        var projectName = projectNames[index];
        var projectDescription = projectDescriptions[index];
        var projectUrl = projectUrls[index];

        return FadeInUpBig(
          duration: const Duration(milliseconds: 1600),
          child: InkWell(
            onTap: () {
              // Open the project link when tapped
              launch(projectUrl);
            },
            onHover: (value) {
              setState(() {
                if (value) {
                  hoveredIndex = index;
                } else {
                  hoveredIndex = null;
                }
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Visibility(
                  visible: index == hoveredIndex,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    transform: index == hoveredIndex ? onHoverEffect : null,
                    curve: Curves.easeIn,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.themeColor.withOpacity(1.0),
                          AppColors.themeColor.withOpacity(0.9),
                          AppColors.themeColor.withOpacity(0.8),
                          AppColors.themeColor.withOpacity(0.6),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          projectName,
                          style: AppTextStyles.montserratStyle(
                            color: Colors.black87,
                            fontSize: 20,
                          ),
                        ),
                        Constants.sizedBox(height: 15.0),
                        Text(
                          projectDescription,
                          style: AppTextStyles.normalStyle(
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Constants.sizedBox(height: 30.0),
                        CircleAvatar(
                          maxRadius: 25,
                          backgroundColor: Colors.white,
                          child: GestureDetector(
                            onTap: () {
                              // Open the project link when share icon is tapped
                              launch(projectUrl);
                            },
                            child: Image.asset(
                              AppAssets.share,
                              width: 25,
                              height: 25,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FadeInDown buildProjectText() {
    return FadeInDown(
      duration: const Duration(milliseconds: 1200),
      child: RichText(
        text: TextSpan(
          text: 'Latest ',
          style: AppTextStyles.headingStyles(fontSize: 30.0),
          children: [
            TextSpan(
              text: 'Projects',
              style: AppTextStyles.headingStyles(
                fontSize: 30,
                color: AppColors.robinEdgeBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
