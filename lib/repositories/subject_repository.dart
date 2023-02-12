import 'package:flutter/material.dart';
import 'package:mybooknote/database/db.dart';
import 'package:mybooknote/entities/subject_entity.dart';
import 'package:sqflite/sqlite_api.dart';

class SubjectRepository {
  late Database db;
  List<SubjectEntity> subjects = [];


  SubjectRepository() {
    _initRepository();
  }

  _initRepository() {
    
  }

  getSubjects () async {
    db = await DB.instance.database;
    List result = await db.query('subjects');
    print(result);
  }

  insert() async {
    db = await DB.instance.database;
    db.insert('subjects', {
      'name': 'Teste',
      'professor': 'prof teste'
    });
  }

}