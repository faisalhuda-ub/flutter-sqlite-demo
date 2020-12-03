import 'package:flutter/material.dart';
import 'package:sqlite_demo/model/student.dart';

class EntryForm extends StatefulWidget {
  final Student student;

  EntryForm(this.student);

  @override
  EntryFormState createState() => EntryFormState(this.student);
}
//class controller
class EntryFormState extends State<EntryForm> {
  Student student;

  EntryFormState(this.student);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (student != null) {
      nameController.text = student.name;
      phoneController.text = student.phone;
    }


    return Scaffold(
        appBar: AppBar(
          title: student == null ? Text('Tambah') : Text('Rubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left:10.0, right:10.0),
          child: ListView(
            children: <Widget> [
              // nama
              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // telepon
              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // tombol button
              Padding (
                padding: EdgeInsets.only(top:20.0, bottom:20.0),
                child: Row(
                  children: <Widget> [
                    // tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (student == null) {
                            // tambah data
                            student = Student(nameController.text, phoneController.text);
                          } else {
                            // rubah data
                            student.name = nameController.text;
                            student.phone = phoneController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek student
                          Navigator.pop(context, student);
                        },
                      ),
                    ),
                    Container(width: 5.0,),
                    // tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}