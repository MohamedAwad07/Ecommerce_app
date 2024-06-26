import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nemo_app/modules/Login%20Page/LoginScreen.dart';
import '../../shared/components/components.dart';
import '../../shared/constants/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool nameEnable = false;
  bool passEnable = false;
  bool addressEnable = false;
  bool phoneEnable = false;

  // var name = userController.text;
  // var pass = passController.text;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(
              title: "Profile",
              backcolor: Color(0xFFFFBC00),
              // backcolor: Colors.transparent,
              textColor: Colors.white),
          Container(
            width: 414,
            height: 194,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/account_wave.png'),
                // Replace with your image path
                fit: BoxFit.cover, // Adjust the image fit based on your needs
              ),
            ),
            child: Stack(
              //alignment: Alignment.bottomRight,
              children: [
                Positioned(
                  bottom: 0,
                  right: 38,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 75,
                    child: Image.asset(
                      "assets/avatar.png",
                      width: 147,
                      height: 147,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                UserInfo(
                    title: "Name",
                    value: username,
                    icon: Icons.person_2_outlined,
                    enable: nameEnable),
                UserInfo(
                    title: "Password",
                    value: "*********",
                    icon: Icons.lock_open_sharp,
                    enable: passEnable),
                UserInfo(
                    title: "Address",
                    value: "Ain Shams",
                    icon: Icons.home_work_outlined,
                    enable: addressEnable),
                UserInfo(
                    title: "Phone number",
                    value: "01095008858",
                    icon: Icons.phone,
                    enable: phoneEnable),
                Spacer(),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 150,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: 20,
                    ),
                    child: defaultMaterialButton(
                      text: 'Log out',
                      isGoogle: false,
                      containerColor: Colors.red,
                      haveBorder: false,
                      textColor: Colors.white,
                      borderColor: Colors.transparent,
                      valid: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
