import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Top image (assuming it's positioned at the top-left)
            Positioned(
              left: 0,
              child: Image.asset(
                "assets/images/main_top.png",
                width: 111.0, // Adjust width as needed
              ),
            ),

            Center(
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Ensures content fits within screen
                children: [
                  SizedBox(height: 35.0), // Spacing above title

                  Text(
                    "Bienvenue !",
                    style: TextStyle(
                        fontSize: adaptTextSize(33.0)), // Adapt font size
                  ),

                  SizedBox(height: 10.0), // Spacing between title and icon

                  SvgPicture.asset(
                    "assets/icons/chat.svg",
                    width: adaptSize(270.0), // Adapt icon size
                  ),

                  SizedBox(height: 50.0), // Spacing between icon and question

                  Text(
                    "Tu es un(e) ?",
                    style: TextStyle(
                      fontSize: adaptTextSize(16.0),
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(
                      height: 30.0), // Spacing between question and buttons

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: adaptSize(150.0), // Adapt button width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          child: Text(
                            "Client",
                            style: TextStyle(
                                fontSize: adaptTextSize(24.0),
                                color: Color.fromARGB(255, 254, 254, 254)),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 13.0,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0), // Spacing between buttons
                      SizedBox(
                        width: adaptSize(150.0), // Adapt button width
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/logint");
                          },
                          child: Text(
                            "Travailleur",
                            style: TextStyle(
                                fontSize: adaptTextSize(24.0),
                                color: Color.fromARGB(255, 254, 254, 254)),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 13.0,
                              ),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to adapt sizes based on screen dimensions (optional)
double adaptSize(double size) {
  // Implement logic to adjust size based on screen width/height of Nexus 6
  // You can use MediaQuery.of(context).size to get screen dimensions
  return size; // Example: return size * MediaQuery.of(context).size.width / 414.0; (assuming Nexus 6 width is 414.0)
}

// Helper function to adapt text size based on screen density (optional)
double adaptTextSize(double size) {
  // Implement logic to adjust text size based on screen density
  return size; // Example: return size * MediaQuery.of(context).textScaleFactor;
}
