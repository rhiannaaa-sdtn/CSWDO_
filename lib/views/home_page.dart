import 'package:cwsdo/widget/home/about.dart';
import 'package:cwsdo/widget/navigation_bar/footer.dart';
import 'package:flutter/material.dart';
import 'package:cwsdo/widget/custom/custom_widget.dart';
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
      appBar: AppBar(
        backgroundColor: const Color(0xff08436d),
        automaticallyImplyLeading: false, // Disable default back button
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align to the left
          children: [
            for (int i = 0; i < navTitles.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: GestureDetector(
                  onTap: () {
                    if (navTitles[i] == 'About') {
                      _scrollController.animateTo(
                        MediaQuery.of(context).size.height * .9,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else if (navTitles[i] == 'Contact') {
                      _scrollController.animateTo(
                        MediaQuery.of(context).size.height * 2.5,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else if (navTitles[i] == 'Home') {
                      _scrollController.animateTo(
                        MediaQuery.of(context).size.height * 0,
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
              ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            children: [
              // MAIN CONTENT
              Container(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight * 1, // Dynamically set height
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
                            aspectRatio: constraints.maxWidth > 600 ? 2.6 : 1,
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
                        
                        // Blue background with low opacity
                        Positioned(
                          top: 0, // Covers the whole height of the screen
                          left: 0,
                          right: 0,
                          bottom: 0, // Adjust if you want it to cover less height
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.3), // Blue background with low opacity
                            ),
                          ),
                        ),
                        
                        // Add Text Over the Carousel
                        Positioned(
                          top: 100, // Adjust to position text
                          child: Column(
                            children: [
                                CustomWidg(txt: 'Community Needs Assesment', fsize: 50),
                    CustomWidg(txt: 'Management System', fsize: 50),
                    SizedBox(height: 20),
                    CustomWidg(txt: 'City of San Pablo', fsize: 30),
                    CustomWidg(
                        txt: 'City Social Welfare and Development Office',
                        fsize: 30),
                            ],
                          ),
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
