import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybooknote/database/db.dart';
import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:sqflite/sqlite_api.dart';

class SubjectRepository implements ISubjectRepository{
  late Database db;

  SubjectRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await getIt<DB>().database;
  }
  
  @override
  Future<void> create({required String name, required String professor}) async {
    await db.insert('subjects', {
      'name': name,
      'professor': professor,
      'images': '[]'
    });
  }
  
  @override
  Future<List> list() async {
    List subjects = await db.query('subjects');
    return subjects;
  }

  @override
  Future<void> delete({required int id}) async {
    await db.delete('subjects', where: 'id = ?', whereArgs: [id]);
  }
  
  @override
  Future<void> addImage({required int id, required String urlImage}) async {
    List subjects = await list();
    List images = jsonDecode(subjects.first["images"]);
    images.add(urlImage);
    List imagesListFormatted = images.map((e) => '"$e"').toList();

    await db.update(
      'subjects',
      {"images": imagesListFormatted.toString()},
      where: 'id = ?',
      whereArgs: [id = 1]
    );
  }
}