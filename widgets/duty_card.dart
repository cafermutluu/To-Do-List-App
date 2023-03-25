// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DutyCard extends StatelessWidget {
  const DutyCard(
      {Key? key,
      this.dutyName,
      required this.isDone,
      required this.dutyStatus,
      this.deleteDuty,
      this.imgPath,
      required this.setImage})
      : super(key: key);

  final String? dutyName;
  final bool isDone;
  final Function(bool?) dutyStatus;
  final Function(void)? deleteDuty;
  final String? imgPath;
  final Function(ImageSource)? setImage;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: deleteDuty,
      child: Card(
        elevation: isDone ? 1 : 5,
        shadowColor: Theme.of(context).primaryColor,
        color: isDone ? Colors.green.shade50 : Colors.black54,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: ExpansionTile(
          leading: IconButton(
            icon: Icon(Icons.add_a_photo_outlined),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Center(child: const Text("Choose Image Type")),
                    actions: <Widget>[
                      // usually buttons at the bottom of the dialog
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          child: const Text("Pick from Gallery"),
                          onPressed: () {
                            setImage!(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          child: const Text("Pick new Photograph"),
                          onPressed: () {
                            setImage!(ImageSource.camera);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          title: Text(
            dutyName!,
            style: TextStyle(
                decoration: isDone ? TextDecoration.lineThrough : null,
                color: isDone ? Colors.black : Colors.white),
          ),
          /*trailing: Checkbox(
            isError: true,
            onChanged: dutyStatus,
            value: isDone,
            checkColor: Colors.white,
            fillColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
            activeColor: Theme.of(context).primaryColor,
          ),*/
          children: [
            imgPath != null
                ? SizedBox(
                    child: Image.file(
                    File(imgPath!),
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ))
                : Container()
          ],
        ),
      ),
    );
  }
}
