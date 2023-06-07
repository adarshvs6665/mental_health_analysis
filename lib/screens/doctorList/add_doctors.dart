import 'package:flutter/material.dart';
import 'package:mental_health_analysis/utils/constants.dart';

class DoctorListPage extends StatefulWidget {
  @override
  _DoctorListPageState createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {
  List<Map<String, String>> doctorsList = [
    {"name": 'Dr Robin', "id": "1"},
    {"name": 'Dr Rajith Kumar', "id": "2"},
    {"name": 'Dr Sudhakaran', "id": "3"},
  ];

  Set<String> selectedNames = Set<String>();

  void addDoctorToChat() {
    print(selectedNames);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        backgroundColor:
            const Color.fromARGB(37, 44, 73, 255), // Set app bar color
        actions: [
          if (selectedNames.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextButton(
                onPressed: () {
                  addDoctorToChat();
                },
                style: TextButton.styleFrom(
                    backgroundColor: kCyan,
                    primary: kDarkBlue,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                child: const Text("Add to chat"),
              ),
            ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: doctorsList.length,
          itemBuilder: (context, index) {
            final name = doctorsList[index]['name'];
            final id = doctorsList[index]['id'];
            final isChecked = selectedNames.contains(id);
            return Card(
                color: kDarkBlue,
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  leading: Checkbox(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        if (isChecked) {
                          selectedNames.remove(id);
                        } else {
                          selectedNames.add(id!);
                        }
                      });
                    },
                  ),
                  title: Text(name!),
                  onTap: () {
                    setState(() {
                      if (isChecked) {
                        selectedNames.remove(id!);
                      } else {
                        selectedNames.add(id!);
                      }
                    });
                  },
                ));
          },
        ),
      ),
    );
  }
}
