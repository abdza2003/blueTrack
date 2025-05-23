import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PersonalAccountPostStatusEnum {
  public(
      id: 100,
      title: 'public',
      subtile: 'public_subtile',
      iosIcon: CupertinoIcons.globe,
      androidIcon: Icons.public),
  private(
      id: 103,
      title: 'private',
      subtile: 'private_subtile',
      iosIcon: CupertinoIcons.lock_fill,
      androidIcon: Icons.lock),
  freind(
      id: 101,
      title: 'my_circle',
      subtile: 'mycircle_subtile',
      iosIcon: CupertinoIcons.group_solid,
      androidIcon: Icons.group),
  ;

  const PersonalAccountPostStatusEnum({
    required this.title,
    required this.id,
    required this.subtile,
    required this.androidIcon,
    required this.iosIcon,
  });

  final String title;
  final String subtile;
  final IconData androidIcon;
  final IconData iosIcon;
  final int id;

  factory PersonalAccountPostStatusEnum.fromWord(String word) {
    return PersonalAccountPostStatusEnum.values.firstWhere(
      (category) => category.title == word,
    );
  }

  @override
  String toString() => title;
}
