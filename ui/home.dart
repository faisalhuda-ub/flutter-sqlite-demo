import 'package:flutter/material.dart';

// deklarasi pemanggilan class dart yang lain
import 'package:sqlite_demo/ui/entry_form.dart';
import 'package:sqlite_demo/model/student.dart';
import 'package:sqlite_demo/helper/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Student> studentList;

  @override
  Widget build(BuildContext context) {
    if (studentList == null) {
      studentList = List<Student>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar mahasiswa'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var student = await navigateToEntryForm(context, null);
          if (student != null) addStudent(student);
        },
      ),
    );
  }

  Future<Student> navigateToEntryForm(BuildContext context, Student student) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) {
              return EntryForm(student);
            }
        )
    );
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
            title: Text(this.studentList[index].name, style: textStyle,),
            subtitle: Text(this.studentList[index].phone),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () {
                deleteStudent(studentList[index]);
              },
            ),
            onTap: () async {
              var student = await navigateToEntryForm(context, this.studentList[index]);
              if (student != null) editStudent(student);
            },
          ),
        );
      },
    );
  }

  // tambah data mahasiswa
  void addStudent(Student student) async {
    int result = await dbHelper.insert(student);
    if (result > 0) {
      updateListView();
    }
  }

   // merubah data mahasiswa
  void editStudent(Student student) async {
    int result = await dbHelper.update(student);
    if (result > 0) {
      updateListView();
    }
  }
  // menghapus data mahssiwa
  void deleteStudent(Student student) async {
    int result = await dbHelper.delete(student.nim);
    if (result > 0) {
      updateListView();
    }
  }
  //update student
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Student>> studentListFuture = dbHelper.getStudentList();
      studentListFuture.then((studentList) {
        setState(() {
          this.studentList = studentList;
          this.count = studentList.length;
        });
      });
    });
  }

}