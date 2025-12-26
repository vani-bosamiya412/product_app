import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboardscreen.dart';

class UpdateproductScreen extends StatefulWidget {
  var id;
  var name;
  var price;
  var des;

  UpdateproductScreen({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.des,
  });

  @override
  State<UpdateproductScreen> createState() => _UpdateproductScreenState();
}

class _UpdateproductScreenState extends State<UpdateproductScreen> {
  TextEditingController pname = TextEditingController();
  TextEditingController pprice = TextEditingController();
  TextEditingController pdes = TextEditingController();

  @override
  void initState() {
    super.initState();
    pname.text = widget.name;
    pprice.text = widget.price;
    pdes.text = widget.des;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Product")),
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
                    "Update Product",
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
                        updateproduct(
                          pname.text,
                          pprice.text,
                          pdes.text,
                          widget.id,
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DashboardScreen(),
                          ),
                        );
                      },
                      child: Text("Update Product"),
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

  updateproduct(String name, String price, String des, id) {
    var url = Uri.parse("https://prakrutitech.xyz/Seminar/update.php");
    http.post(
      url,
      body: {
        "id": id,
        "pname": name,
        "pprice": price,
        "pdes": des,
      },
    );
  }
}