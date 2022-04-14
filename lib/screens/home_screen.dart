import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mithab_test/common/paths.dart';
import 'package:mithab_test/repositories/authentication_repository.dart';
import 'package:mithab_test/screens/login_screen.dart';
import 'package:mithab_test/screens/preview_screen.dart';
import 'package:mithab_test/widgets/custom_animated_button.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(phoneImagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Color.fromARGB(255, 207, 89, 81),
                    size: 20.sp,
                  ),
                  onPressed: () async {
                    await context.read<AuthenticationRepository>().signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                ),
                child: CustomAnimatedButton(
                  btnFirstColor: Colors.black.withOpacity(0.6),
                  btnLastColor: Colors.black.withOpacity(0.9),
                  btnFirstSize: Size(50.w, 10.h),
                  btnLastSize: Size(52.w, 11.h),
                  duration: Duration(seconds: 2),
                  text: 'R E C O R D',
                  textColor: Color.fromARGB(255, 207, 89, 81),
                  icon: Icons.fiber_manual_record,
                  onPressed: () async {
                    File? video;
                    await ImagePicker()
                        .pickVideo(source: ImageSource.camera)
                        .then(
                      (pickedXFile) {
                        if (pickedXFile != null) {
                          video = File(pickedXFile.path);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PreviewScreen(video: video!),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
