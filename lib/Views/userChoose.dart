
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'package:ums/Login/login.dart';
import 'package:ums/teacher/t_dashboard.dart';


class UserChose extends StatelessWidget {
  UserChose({Key? key}) : super(key: key);
  final ctrl = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: ctrl,
        children: const [Page('admin'), Page('teacher'), Page('student')],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final String type;
  const Page(this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     /* onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage(type)));
      },*/
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('$type.png',
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.75,
                fit: BoxFit.cover),
            const SizedBox(
              height: 20,
            ),
            Text(type,
                style: const TextStyle(
                    color: primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
