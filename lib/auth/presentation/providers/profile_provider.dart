import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import '../../domain/dto/profile.dto.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileDTO _profile = ProfileDTO();

  ProfileDTO get profile => _profile;

  void setProfile(ProfileDTO newProfile) {
    _profile = newProfile;
    notifyListeners();
  }

  void updateFirstName(String value) {
    _profile.firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    _profile.lastName = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _profile.email = value;
    notifyListeners();
  }

  void updateDni(String value) {
    _profile.dni = value;
    notifyListeners();
  }

  void updateAge(int value) {
    _profile.age = value;
    notifyListeners();
  }

  void updatePhone(String value) {
    _profile.phone = value;
    notifyListeners();
  }

  void updateStreet(String value) {
    _profile.street = value;
    notifyListeners();
  }

  void updateNeighborhood(String value) {
    _profile.neighborhood = value;
    notifyListeners();
  }

  void updateCity(String value) {
    _profile.city = value;
    notifyListeners();
  }

  void updateDistrict(String value) {
    _profile.district = value;
    notifyListeners();
  }

  void clearProfile() {
    _profile = ProfileDTO();
    notifyListeners();
  }
}
