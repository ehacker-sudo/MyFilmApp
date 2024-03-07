import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/auth/register.dart';
import 'package:myfilmapp/widgets/logo_app.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return MyFilmAppColors.submain;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0x33e5e5e5),
                  // Red border with the width is equal to 5
                  border: Border.all(width: 1, color: const Color(0xffe5e5e5))),
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const LogoApp(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const Text(
                    "Đăng nhập",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.email),
                      // suffixIcon: Icon(Icons.clear),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextField(
                    obscureText: !isChecked,
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: MyFilmAppColors.white,
                        fillColor:
                            MaterialStateProperty.all(MyFilmAppColors.submain),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(
                            () {
                              isChecked = value!;
                            },
                          );
                        },
                      ),
                      const Text(
                        "Hiện mật khẩu",
                        style: TextStyle(
                            color: MyFilmAppColors.black, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyFilmAppColors.submain,
                        textStyle: const TextStyle(fontSize: 14.0),
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Đăng nhập",
                        style: TextStyle(
                            color: MyFilmAppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Chưa có tài khoản?",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyFilmAppColors.white,
                        textStyle: const TextStyle(fontSize: 14.0),
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3.0)),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        "Tạo một tài khoản mới",
                        style: TextStyle(
                            color: MyFilmAppColors.black, fontSize: 16),
                      ),
                    ),
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
