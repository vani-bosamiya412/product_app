import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/productmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addproduct.dart';
import 'login.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var data;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkvalue();
  }

  Future<List<dynamic>> getproducts() async {
    var url = Uri.parse("https://prakrutitech.xyz/Seminar/view.php");
    var resp = await http.get(url);
    return jsonDecode(resp.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              data ?? "",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: logout,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: FutureBuilder<List<dynamic>>(
          future: getproducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ProductModel(list: snapshot.data!);
            }

            return Center(
              child: Text(
                "No products available",
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text(
          "Add Product",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => AddproductScreen()),
          );
        },
      ),
    );
  }

  void logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("tops_login", true);
    sharedPreferences.remove("myemail");

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
    );
  }

  checkvalue() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      data = sharedPreferences.getString("myemail");
    });
  }
}