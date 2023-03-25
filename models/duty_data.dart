import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/models/duty_properties.dart';

class DutyData with ChangeNotifier {
  final List<Duty> _duties = [];

  static SharedPreferences? _sharedPref;
  final List<String> _dutiesAsString = [];

  void changeDutyStatus(int index) {
    _duties[index].dutyStatus();
    saveDutiesToSharedPref(_duties);
    notifyListeners();
  }

  void addDuty(Duty newDuty) {
    _duties.add(Duty(dutyName: newDuty.dutyName, imagePath: newDuty.imagePath));
    saveDutiesToSharedPref(_duties);
    notifyListeners();
  }

  void deleteDuty(int index) {
    _duties.removeAt(index);
    saveDutiesToSharedPref(_duties);
    notifyListeners();
  }

  UnmodifiableListView<Duty> get duties => UnmodifiableListView(_duties);

  //SharedPref metotları.
  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void saveDutiesToSharedPref(List<Duty> duties) {
    _dutiesAsString.clear();

    for (var duty in duties) {
      _dutiesAsString.add(jsonEncode(duty.toMap()));
    }

    _sharedPref!.setStringList("toDoData", _dutiesAsString);
  }

  void loadDutiesFromSharedPref() {
    List<String>? tempList = _sharedPref!.getStringList("toDoData") ?? [];
    _duties.clear();
    for (var duty in tempList) {
      _duties.add(Duty.fromMap(jsonDecode(duty)));
    }
  }

  void setImage(int dutyIndex, ImageSource source) async {
    final pickedImage =
        await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      _duties[dutyIndex].imagePath = pickedImage.path.toString();
      _sharedPref!.setString('path', pickedImage.path.toString());
    }

    saveDutiesToSharedPref(_duties);
    loadDutiesFromSharedPref();
    notifyListeners();
  }
}
