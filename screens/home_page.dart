// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/models/duty_data.dart';
import 'package:to_do_list/screens/duty_adder.dart';
import 'package:to_do_list/screens/settings_page.dart';
import 'package:to_do_list/widgets/duty_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
              icon: Icon(Icons.settings))
        ],
        title: Text("To Do List"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                      "${Provider.of<DutyData>(context).duties.length} duties added",
                      style: Theme.of(context).textTheme.titleLarge),
                )),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white24),
                      child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Consumer<DutyData>(
                              builder: (context, itemData, child) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  reverse: true,
                                  itemCount: itemData.duties.length,
                                  itemBuilder: (context, index) => DutyCard(
                                        imgPath:
                                            itemData.duties[index].imagePath,
                                        setImage: (source) {
                                          Provider.of<DutyData>(context,
                                                  listen: false)
                                              .setImage(index, source );
                                        },
                                        dutyName:
                                            itemData.duties[index].dutyName!,
                                        isDone: itemData.duties[index].isDone,
                                        dutyStatus: (_) {
                                          itemData.changeDutyStatus(index);
                                        },
                                        deleteDuty: (_) {
                                          itemData.deleteDuty(index);
                                        },
                                      )),
                            );
                          }))),
                )),
            FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => DutyAdder(),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))));
                },
                child: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
