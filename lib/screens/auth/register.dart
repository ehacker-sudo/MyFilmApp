import 'package:flutter/material.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/screens/auth/login.dart';
import 'package:myfilmapp/widgets/logo_app.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
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
                    "Đăng ký",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.email),
                      // suffixIcon: Icon(Icons.clear),
                      labelText: 'Họ và tên',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      // prefixIcon: Icon(Icons.email),
                      // suffixIcon: Icon(Icons.clear),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: !isChecked,
                    decoration: const InputDecoration(
                      labelText: 'Mật khẩu',
                      helperText: "Mật khẩu phải có ít nhất 8 kí tự",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: !isChecked,
                    decoration: const InputDecoration(
                      labelText: 'Xác nhận mật khẩu',
                      border: OutlineInputBorder(),
                    ),
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
                    height: 30,
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
                        "Tạo tài khoản",
                        style: TextStyle(
                            color: MyFilmAppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Đã có tài khoản?",
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
                              builder: (context) => const Login()),
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
                        "Đăng nhập",
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
