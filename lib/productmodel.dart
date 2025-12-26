import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'updateproduct.dart';
import 'dashboardscreen.dart';

class ProductModel extends StatelessWidget {
  final List list;

  const ProductModel({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list[index]["pname"],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  "₹ ${list[index]["pprice"]}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  list[index]["pdes"],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UpdateproductScreen(
                              id: list[index]["id"],
                              name: list[index]["pname"],
                              price: list[index]["pprice"],
                              des: list[index]["pdes"],
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.teal,
                      tooltip: "Edit",
                    ),

                    SizedBox(width: 8),

                    IconButton(
                      onPressed: () {
                        deletedata(list[index]["id"]);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DashboardScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      tooltip: "Delete",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void deletedata(id) {
    http.post(
      Uri.parse("https://prakrutitech.xyz/Seminar/delete.php"),
      body: {"id": id},
    );
  }
}