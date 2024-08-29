import 'package:flutter_application_1/pages/data.dart';
// import 'package:flutter_myapplication_1/pages/data.dart';
import 'package:flutter/material.dart';

class MultipleNotifier extends ChangeNotifier {
     List<String> _selectedItems;
     MultipleNotifier(this._selectedItems);
     List<String> get selectedItems => _selectedItems;
     bool isHaveItem(String value) => _selectedItems.contains(value);
     addItem(String value) {
          if (!isHaveItem(value)) {
               _selectedItems.add(value);
               notifyListeners();
          }
     }

     removeItem(String value) {
          if (isHaveItem(value)) {
               _selectedItems.remove(value);
               notifyListeners();
          }
     }
}

class SingleNotifier extends ChangeNotifier {
     String _currentLanguage = languages[0];
     SingleNotifier();
     String get currentLanguage => _currentLanguage;
     updateLanguage(String value) {
          if (value != _currentLanguage) {
               _currentLanguage = value;
               notifyListeners();
          }
     } 
}
