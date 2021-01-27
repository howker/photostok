import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:photostok/models/photo_list.dart';

class CloseDialogButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Close'),
    );
  }
}

class SaveButton extends StatelessWidget {
  final Photo photo;

  const SaveButton({Key key, this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: const Text('Download'),
      onPressed: () {
        Navigator.of(context).pop();
        try {
          GallerySaver.saveImage('${photo.urls.regular}.jpg');
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success'),
              content: const Text('Photo was successfully saved'),
              actions: [
                CloseDialogButton(),
              ],
            ),
          );
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('Error ocured while saving photo'),
              actions: [
                CloseDialogButton(),
              ],
            ),
          );
        }
      },
    );
  }
}
