import 'package:cwsdo/widget/home/about.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/custom/custom_widget.dart';
import 'package:cwsdo/widget/navigation_bar/navigation_bar.dart';
import 'package:cwsdo/constatns/navitem.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int _currentIndex = 0; 
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// Now Navbar is valid as appBar
  body: LayoutBuilder(
    builder: (context, constraints) {
      return ListView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        children: [
               Container(
            height: MediaQuery.of(context).size.height * .1,
            width: double.maxFinite,
            color: const Color(0xff08436d),
            child: Row(
              children: [
                const Spacer(),
                for (int i = 0; i < navTitles.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        if (navTitles[i] == 'About') {
                          _scrollController.animateTo(
                            MediaQuery.of(context).size.height * 1.5,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else if (navTitles[i] == 'Contact') {
                          _scrollController.animateTo(
                            MediaQuery.of(context).size.height * 2.5,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        } else if (navTitles[i] == 'Admin') {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          Navigator.pushNamed(context, navLinks[i]);
                        }
                      },
                      child: CustomWidg(txt: navTitles[i], fsize: 30),
                    ),
                  )
              ],
            ),
          ),
          // MAIN CONTENT
          Container(
            height: constraints.maxHeight * .9,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage("images/bg1.png"),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter, // Position the indicator at the bottom center
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: constraints.maxWidth > 600 ? 2.6 : 2,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index; // Update the index when the page changes
                          });
                        },
                      ),
                      items: [
                        buildCarouselSlide("images/carousel1.jpg"),
                        buildCarouselSlide("images/carousel2.jpg"),
                        buildCarouselSlide("images/carousel3.jpg"),
                      ],
                    ),
                    // Page indicator positioned inside the carousel
                    Positioned(
                      bottom: 20, // Adjust the position as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const About(),
          const Footer(),
        ],
      );
    },
  ),
);

  }
}


  Widget buildCarouselSlide(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
    );
  }
