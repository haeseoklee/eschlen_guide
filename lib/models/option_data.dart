import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class OptionData extends ChangeNotifier {

  int checkedNum = 0;

  List isChecked = [
    [false, false],
    [false, false],
    [false, false]
  ];

  String getProperty(i, j){
    String property;
    if (i == 0 && j == 0){
      property = 'random';
    }else if(i == 0 && j == 1) {
      property = 'nearest';
    }else if(i == 1 && j == 0){
      property = 'chinese';
    }else if(i == 1 && j == 1){
      property = 'japanese';
    }else if(i == 2 && j == 0){
      property = 'liquor';
    }else if(i == 2 && j == 1){
      property = 'cafe';
    }
    return property;
  }

  Map getFilteredOptions() {
    var filteredOptions = new Map();
    for(var i=0 ; i < isChecked.length ; i++){
      for(var j=0 ; j < isChecked[i].length ; j++){
        String property = getProperty(i, j);
        if(isChecked[i][j]){
          filteredOptions[property] = true;
        }else{
          filteredOptions[property] = false;
        }
      }
    }
    return filteredOptions;
  }

  void switchOptions(int i, int j) {
    isChecked[i][j] = !isChecked[i][j];
    if (isChecked[i][j]){
      checkedNum++;
    }else{
      checkedNum--;
    }
    notifyListeners();
  }

  int getCheckedNum() {
    return checkedNum;
  }

}