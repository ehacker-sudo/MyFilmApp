import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfilmapp/screens/auth/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const Navbar(),
      body: Container(
        decoration: const BoxDecoration(color: MyFilmAppColors.body),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/user.svg',
                    height: 20,
                  ),
                  // CircleAvatar(
                  //   backgroundColor: Colors.white,
                  //   child: Text('AH'),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Đăng nhập",
                    style:
                        TextStyle(color: MyFilmAppColors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(top: 5, bottom: 5)),
                  backgroundColor: MaterialStateProperty.all(
                    MyFilmAppColors.submain,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      // Change your radius here
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                child: const Text(
                  "Đăng nhập / Đăng ký",
                  style: TextStyle(color: MyFilmAppColors.white, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lịch sử xem",
                    style:
                        TextStyle(color: MyFilmAppColors.white, fontSize: 15),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
