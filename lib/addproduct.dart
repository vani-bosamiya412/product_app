import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboardscreen.dart';

class AddproductScreen extends StatefulWidget {
  const AddproductScreen({super.key});

  @override
  State<AddproductScreen> createState() => _AddproductScreenState();
}

class _AddproductScreenState extends State<AddproductScreen> {
  TextEditingController pname = TextEditingController();
  TextEditingController pprice = TextEditingController();
  TextEditingController pdes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Add New Product",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 20),

                  TextField(
                    controller: pname,
                    decoration: InputDecoration(
                      hintText: "Product Name",
                      prefixIcon: Icon(Icons.shopping_bag),
                    ),
                  ),
                  SizedBox(height: 12),

                  TextField(
                    controller: pprice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Product Price",
                      prefixIcon: Icon(Icons.currency_rupee),
                    ),
                  ),
                  SizedBox(height: 12),

                  TextField(
                    controller: pdes,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Product Description",
                      prefixIcon: Icon(Icons.description),
                    ),
                  ),
                  SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        addproduct(
                          pname.text,
                          pprice.text,
                          pdes.text,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DashboardScreen(),
                          ),
                        );
                      },
                      child: Text("Add Product"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addproduct(var name, var price, var des) {
    var url = Uri.parse("https://prakrutitech.xyz/Seminar/insert.php");
    http.post(
      url,
      body: {
        "pname": name,
        "pprice": price,
        "pdes": des,
      },
    );
  }
}