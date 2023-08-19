import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:project1/models/database.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  // for switch
  bool swicthData = false;
  // database
  AppDb database = AppDb();
  // insert data
  Future insert(String name) async {
    var now = DateTime.now();
    var dataResponse = await database.into(database.todo).insertReturning(
          TodoCompanion.insert(name: name, createdAt: now, updatedAt: now),
        );
  }

  // get data
  Future<List<Todos>> getAll() {
    return database.select(database.todo).get();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Switch(
                        inactiveThumbColor: Colors.red,
                        value: swicthData,
                        onChanged: (value) {
                          setState(() {
                            swicthData = value;
                          });
                        },
                      ),
                      Text(
                        "Add Transactions",
                        style: TextStyle(
                            color: (swicthData == false)
                                ? Colors.red
                                : Colors.green),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      insert('Bangun Pagi');
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              FutureBuilder(
                future: getAll(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          print(snapshot.data);
                          return Card(
                            child: ListTile(
                              title: Text(snapshot.data![index].name),
                              trailing: Text(snapshot.data![index].createdAt.day
                                  .toString()),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text("kosong"),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
