import 'package:flutter/material.dart';
import 'Biblioteca.dart';
import 'Intrebari.dart';
import 'bookWidget.dart';
import 'Progres.dart';
import 'file_utils.dart';
import 'book_manager.dart';
import 'dart:io';
import 'books.dart';
import 'toWidget.dart';
import 'intrebare.dart';
import 'lista_intrebari.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = 'lecTUra';
  void init() async {
    intrebari=new List<sInt>();
    String aux = await FileUtils.getFilePath;
    String data=await getFileData('assets/recomandate.txt');
    int ind=0,nr=0;
    while(ind<data.length && data.codeUnitAt(ind)>='0'.codeUnitAt(0) && data.codeUnitAt(ind)<='9'.codeUnitAt(0)){
        nr=nr*10+data.codeUnitAt(ind)-'0'.codeUnitAt(0);
        ind++;
    }
    for(int i=1;i<=nr;i++){
        String aux="";
        while(ind<data.length && data.codeUnitAt(ind)!='"'.codeUnitAt(0))
            ind++;
        ind++;
        while(ind<data.length && data.codeUnitAt(ind)!='"'.codeUnitAt(0)) {
          aux+=data[ind];
          ind++;
        }
        sInt a=new sInt();
        a.titlu=aux;
        aux=aux.replaceAll(" ", "");
        String d1=await getFileData('assets/${aux}_intrebari.txt');
        a.lint=getQuestions(d1);
        ind++;
        intrebari.add(a);
    }
    
    new Directory('$aux/books').create().then((Directory directory) {
    });
    bm = new bookManager();
    int k = 0, nb = 0;
    String books = await FileUtils.readFromFile("books.txt");
    while (k < books.length &&
        books.codeUnitAt(k) >= '0'.codeUnitAt(0) &&
        books.codeUnitAt(k) <= '9'.codeUnitAt(0)) {
      nb = nb * 10 + books.codeUnitAt(k) - '0'.codeUnitAt(0);
      k++;
    }
    for (int i = 1; i <= nb; i++) {
      String nume = "";
      while (k < books.length && books.codeUnitAt(k) != '"'.codeUnitAt(0)) k++;
      k++;
      while (k < books.length && books.codeUnitAt(k) != '"'.codeUnitAt(0)) {
        nume += books[k];
        k++;
      }
      k++;
      String content = await FileUtils.readFromFile('books/$nume.txt');
      bm.addBook(newBook(content));
    }
    lastbook = bm.unfinishedBooks[0];
  }

  @override
  Widget build(BuildContext context) {
    init();
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

TextStyle stil20 = new TextStyle(
  fontSize: 20,
  fontFamily: 'Julius',
  fontWeight: FontWeight.bold,
);

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: stil20,
        ),
        backgroundColor: Color.fromRGBO(40, 53, 234, 1),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
        'Asistentul tau personal in materie de carti.',
        style: stil20,
              textAlign: TextAlign.center,
      ),
          )),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'lecTUra',
                style: new TextStyle(
                  fontSize: 35,
                  fontFamily: 'Julius',
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(40, 234, 221, 1),
              ),
            ),
            ListTile(
              title: Text(
                'Biblioteca',
                style: stil20,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Biblioteca()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Intrebari',
                style: stil20,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Intrebari()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Progres',
                style: stil20,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Progres()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
