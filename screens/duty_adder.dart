import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/duty_data.dart';
import 'package:to_do_list/models/duty_properties.dart';

class DutyAdder extends StatelessWidget {
  const DutyAdder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    String? imagePath;
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: TextField(
              maxLines: 3,
              minLines: 1,
              controller: textController,
              decoration: InputDecoration(
                  labelText: "Add New Duty",
                  hintText: "...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  FocusNode(debugLabel: textController.text);
                  Provider.of<DutyData>(context, listen: false).addDuty(Duty(
                      dutyName: textController.text, imagePath: imagePath));
                  Navigator.pop(context);
                },
                child: const Text("Save Duty", textAlign: TextAlign.center),
              ),
              const Padding(padding: EdgeInsets.all(8.0)),
            ],
          ),
        ],
      ),
    );
  }
}
