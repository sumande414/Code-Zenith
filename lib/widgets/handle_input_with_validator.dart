import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/codeforce_model.dart';
import 'form_container_widget.dart';
import 'package:friendz_code/api/api.dart';
import 'lookup_widget.dart';

class HandleInputWithValidator extends StatelessWidget {
  HandleInputWithValidator(
      {super.key, required this.handle, required this.scale});

  double scale;
  final TextEditingController handle;
  bool isHandleValidated = false;
  late Future<Codeforces?> user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 190 * scale,
            child: FormContainerWidget(
              controller: handle,
              hintText: (scale < 1) ? "CF Handle" : "Codeforces ID",
              onChanged: (str) {
                isHandleValidated = false;
              },
              validator: (value) {
                if (!isHandleValidated) {
                  return "Click on lookup and confirm";
                }
              },
            )),
        SizedBox(
          width: 10 * scale,
        ),
        Container(
          width: 150 * scale,
          height: 50,
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 42, 5, 71)),
              iconColor: MaterialStateProperty.all(Colors.white),
              
            ),
            onPressed: () {
              user = api.fetchHandle(handle.text);

              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    FutureBuilder<Codeforces?>(
                        future: user,
                        builder: (context, snapshot) {
                          print("Snapshot data: ${snapshot.data}");
                          if (snapshot.hasData && snapshot.data!.results.isNotEmpty) {
                            return Column(
                              children: [
                                LookupCard(user: snapshot.data!.results[0]),
                                ElevatedButton(
                                    onPressed: () {
                                      isHandleValidated = true;
                                      Navigator.pop(context);
                                    },
                                    child: Text("Confirm"))
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })
                  ],
                ),
              );
            },
            
            icon: Icon(Icons.search),
            label: Text("Lookup",style: TextStyle(
              color: Colors.white
            ),),
          ),
        )
      ],
    );
  }
}
