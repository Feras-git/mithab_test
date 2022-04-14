import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import 'package:mithab_test/common/constants.dart';
import 'package:mithab_test/utils/app_dialogs.dart';
import 'package:mithab_test/widgets/custom_button.dart';

class PreviewScreen extends StatefulWidget {
  final File video;
  const PreviewScreen({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.file(widget.video);
    _videoPlayerController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        // autoPlay: true,
        // looping: true,
      );
      setState(() {
        //
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 70.h,
              color: kMainColor,
              child: _chewieController != null
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : Container(),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Save',
                      icon: Icons.save,
                      onPressed: () async {
                        AppDialogs.showLoading();
                        await GallerySaver.saveVideo(
                          widget.video.path,
                          albumName: 'Mithab',
                        );
                        AppDialogs.dismissLoading();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: CustomButton(
                      text: 'Discard',
                      icon: Icons.cancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
