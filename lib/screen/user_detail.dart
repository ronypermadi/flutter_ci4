import 'package:flutter/material.dart';
import 'package:flutter_ci4/model/user.dart';
import 'package:flutter_ci4/service/user_service.dart';
import 'package:flutter_ci4/util/capitalize.dart';

class DetailUser extends StatefulWidget {
  // create variabel id untuk menghandle param yang diberikan (wajib ada @required)
  final int id;
  // constructor
  DetailUser({@required this.id, Key key}) : super(key: key);

  @override
  _DetailUserState createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  // create variabel untuk menampung User Api Service
  UserApiService apiService;
  // create variabel _user untuk menampung model User
  User _user;

  @override
  void initState() {
    // inisialisasi state apiService dengan class UserApiService
    apiService = UserApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // header
      appBar: AppBar(
        title: Text("Detail User"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      // body
      body: Center(
        child: FutureBuilder<User>(
            // panggil function getUserBy(int id)
            future: apiService.getUserBy(widget.id),
            builder: (context, snapshot) {
              // jika connection none atau data = null
              if (snapshot.connectionState == ConnectionState.none &&
                  snapshot.hasData == null) {
                return LinearProgressIndicator();

                // jika connection berhasil
              } else if (snapshot.connectionState == ConnectionState.done) {
                // tampung data dari server
                _user = snapshot.data;

                // jika data ada / tidak null
                if (_user.id != 0) {
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Image.asset(
                          'assets/images/${_user.gender}.png',
                          width: 150.0,
                          height: 150.0,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_box),
                        title: Text(_user.fullName),
                        subtitle: const Text('Nama'),
                      ),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text(_user.phone),
                        subtitle: const Text('No.Hp'),
                      ),
                      ListTile(
                        leading: Icon(Icons.label),
                        title: Text(capitalize(_user.gender)),
                        subtitle: const Text('Jenis Kelamin'),
                      ),
                      ListTile(
                        leading: Icon(Icons.school),
                        title: Text(_user.grade.toUpperCase()),
                        subtitle: const Text('Jenjang'),
                      ),
                    ],
                  );
                  // jika data null / tidak ada
                } else {
                  return Text("User Not Found");
                }

                // tampilkan container kosong jika terjadi hal lainnya
              } else {
                return Center(
                  child: Container(),
                );
              }
            }),
      ),
    );
  }
}
