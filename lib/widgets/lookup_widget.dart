import 'package:flutter/material.dart';
import 'package:friendz_code/models/codeforce_model.dart';

class LookupCard extends StatelessWidget {
  const LookupCard({super.key, required this.user});
  
  final Result user;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                  radius: 40,
                ),
              ),
              Container(
                width: 170,
                child: Card(color: Colors.green[100],
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Handle : ${user.handle}"),
                          Text("City : ${user.city}"),
                          Text("Country : ${user.country}"),
                          Text("Organisation : ${user.organisation}"),
                          Text("Rating : ${user.rating}"),
                          Text("Rank : ${user.rank}")
                        ]),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
        ]),
      ),
    );
  }
}
