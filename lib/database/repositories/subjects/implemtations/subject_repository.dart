import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mybooknote/database/db.dart';
import 'package:mybooknote/database/repositories/subjects/i_subject_repository.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:mybooknote/main.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';

class SubjectRepository implements ISubjectRepository{
  late Database db;

  SubjectRepository() {
    _initRepository();
  }

  _initRepository() async {
    db = await getIt<DB>().database;
  }
  
  @override
  Future<SubjectEntity> create({required String name, required String professor}) async {
    var subject = {
      'id': const Uuid().v4(),
      'name': name,
      'professor': professor,
      'images': '[]'
    };
    await db.insert('subjects', subject);
    return SubjectEntity.fromJson(subject);
    
  }
  
  @override
  Future<List<SubjectEntity>> list() async {
    List subjects = await db.query('subjects');
    List<SubjectEntity> list = subjects.map((e) => SubjectEntity.fromJson(e)).toList();
    return list;
  }

  @override
  Future<void> delete({required int id}) async {
    await db.delete('subjects', where: 'id = ?', whereArgs: [id]);
  }
  
  @override
  Future<void> addImage({required int id, required String urlImage}) async {
    List<SubjectEntity> subjects = await list();
    List<dynamic> images = jsonDecode(subjects.first.images);
    images.add(urlImage);
    List<String> imagesListFormatted = images.map((e) => '"$e"').toList();

    await db.update(
      'subjects',
      {"images": imagesListFormatted.toString()},
      where: 'id = ?',
      whereArgs: [id = id]
    );
  }

  @override
  Future<List<String>> listImages() async {
    List<SubjectEntity> subjects = await list();
    List<dynamic> images = jsonDecode(subjects.first.images);
    List<String> imagesFormatted = images.map((item) => item.toString()).toList();
    return imagesFormatted;
  }
}