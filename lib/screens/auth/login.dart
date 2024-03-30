import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/message.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:myfilmapp/screens/auth/profile.dart';
import 'package:myfilmapp/screens/auth/register.dart';
import 'package:myfilmapp/screens/home/home.dart';
import 'package:myfilmapp/widgets/logo_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late bool showNavigationDrawer;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = "";
  String password = "";
  bool isChecked = false;
  late Future<Message> _futureAuth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 500;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _futureAuth = TheMovieDbClient().login(User());
  }

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

    _futureAuth.then(
      (value) {
        if (value.result) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Profile()),
          );
        }
      },
    );
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
            FutureBuilder<Message>(
              future: _futureAuth,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    width: showNavigationDrawer
                        ? 500
                        : MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        if (snapshot.hasError)
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Text(
                                  '${snapshot.error}',
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        const Text(
                          "Đăng nhập",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextField(
                          controller: emailController,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.email),
                            // suffixIcon: Icon(Icons.clear),
                            labelText: 'Email',
                            border: const OutlineInputBorder(),
                            suffixIcon: (email != "")
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        email = "";
                                        emailController.text = "";
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Color(0xFF9A9A9A),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          obscureText: !isChecked,
                          controller: passwordController,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            border: const OutlineInputBorder(),
                            suffixIcon: (password != "")
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        password = "";
                                        passwordController.text = "";
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Color(0xFF9A9A9A),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: MyFilmAppColors.white,
                              fillColor: MaterialStateProperty.all(
                                  MyFilmAppColors.submain),
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
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _futureAuth = TheMovieDbClient().login(User(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyFilmAppColors.submain,
                              textStyle: const TextStyle(fontSize: 14.0),
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.0)),
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
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
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
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 20.0),
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3.0)),
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
                  );
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
