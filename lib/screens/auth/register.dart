import 'package:flutter/material.dart';
import 'package:myfilmapp/api/film_api.dart';
import 'package:myfilmapp/constants/theme.dart';
import 'package:myfilmapp/model/message.dart';
import 'package:myfilmapp/model/user.dart';
import 'package:myfilmapp/screens/auth/login.dart';
import 'package:myfilmapp/widgets/logo_app.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late bool showNavigationDrawer;
  late Future<Message> _futureRegister;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String email = "";
  String password = "";
  String name = "";
  String confirmPassword = "";
  bool isChecked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 500;
  }

  @override
  void initState() {
    super.initState();

    _futureRegister = TheMovieDbClient().register(User());
  }

  showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: MyFilmAppColors.submain,
      behavior: SnackBarBehavior.floating,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    _futureRegister.then(
      (value) {
        if (value.result) {
          showSnackBar("Đăng ký thành công");
        }
      },
    );
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: const Color(0x33e5e5e5),
                  // Red border with the width is equal to 5
                  border: Border.all(width: 1, color: const Color(0xffe5e5e5))),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: const Center(
                      child: LogoApp(),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    alignment: AlignmentDirectional.centerStart,
                    width: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: MyFilmAppColors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder<Message>(
                future: _futureRegister,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      width: showNavigationDrawer
                          ? 500
                          : MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          if (snapshot.hasData)
                            if (snapshot.data!.result)
                              const Text(
                                "Đăng ký",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: nameController,
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Họ và tên',
                              border: const OutlineInputBorder(),
                              suffixIcon: (name != "")
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          name = "";
                                          nameController.text = "";
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
                            height: 10,
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
                            height: 10,
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: !isChecked,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Mật khẩu',
                              helperText: "Mật khẩu phải có ít nhất 8 kí tự",
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
                            height: 10,
                          ),
                          TextField(
                            controller: confirmPasswordController,
                            obscureText: !isChecked,
                            onChanged: (value) {
                              setState(() {
                                confirmPassword = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Xác nhận mật khẩu',
                              border: const OutlineInputBorder(),
                              suffixIcon: (confirmPassword != "")
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          confirmPassword = "";
                                          confirmPasswordController.text = "";
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
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _futureRegister =
                                      TheMovieDbClient().register(User(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text,
                                  ));
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyFilmAppColors.submain,
                                textStyle: const TextStyle(fontSize: 14.0),
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.0)),
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
                                      builder: (context) => const Login()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MyFilmAppColors.white,
                                textStyle: const TextStyle(fontSize: 14.0),
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0),
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.0)),
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
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  }

                  // By default, show a loading spinner.
                  return const Column(
                    children: [CircularProgressIndicator()],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
