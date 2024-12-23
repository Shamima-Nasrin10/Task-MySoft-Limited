import 'package:flutter/material.dart';
import 'package:patient_registration_flutter/patient_entity.dart';
import 'package:patient_registration_flutter/patient_service.dart';
import 'package:patient_registration_flutter/util/URL.dart';
import 'package:patient_registration_flutter/util/alert_util.dart';
import 'package:patient_registration_flutter/util/api_response.dart';


class PatientViewPage extends StatefulWidget {
  const PatientViewPage({Key? key}) : super(key: key);

  @override
  _PatientViewPageState createState() => _PatientViewPageState();
}

class _PatientViewPageState extends State<PatientViewPage> {
  List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    loadPatients();
  }

  Future<void> deletePatient(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Patient"),
        content: const Text("Are you sure you want to delete this patient?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final response = await PatientService().deletePatientById(id);
      if (response.successful) {
        setState(() {
          patients.removeWhere((patient) => patient.id == id);
        });
        AlertUtil.success(context, ApiResponse(successful: true, message: "Patient deleted successfully"));
      } else {
        AlertUtil.error(context, response);
      }
    }
  }


  Future<void> loadPatients() async {
    final response = await PatientService().getAllPatients();
    if (response.successful) {
      setState(() {
        if (response.data != null && response.data!['patients'] != null) {
          patients = (response.data!['patients'] as List)
              .map((json) => Patient.fromJson(json))
              .toList();
        } else {
          AlertUtil.error(context, ApiResponse(successful: false, message: 'Invalid data format'));
        }
      });
    } else {
      AlertUtil.error(context, response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Patient List",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: patients.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "No patients available.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                },
                icon: const Icon(Icons.add),
                label: const Text("Add New Patient"),
              ),
            ],
          ),
        )
            : ListView.builder(
          itemCount: patients.length,
          itemBuilder: (context, index) {
            final patient = patients[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Patient Image
                    if (patient.image != null)
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${ApiURL.baseURL}/image/${patient.image}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    else
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: const Center(
                          child: Text(
                            "No Image",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    const SizedBox(width: 16),
                    // Patient Information
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${patient.firstName ?? '-'} ${patient.lastName ?? '-'}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Age: ${patient.age ?? '-'}'),
                          Text('Gender: ${patient.gender ?? '-'}'),
                          Text('Permanent Address: ${patient.permanentAddress ?? '-'}'),
                          Text('Present Address: ${patient.presentAddress ?? '-'}'),
                          Text('Mobile: ${patient.mobileNo ?? '-'}'),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Action Buttons
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            deletePatient(patient.id!);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
