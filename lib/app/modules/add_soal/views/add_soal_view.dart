import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_soal_controller.dart';
import '../../../data/models/soal_model.dart';

class AddSoalView extends GetView<AddSoalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Soal'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputField(
                label: 'Nama Tugas',
                controller: controller.namaTugasController,
                icon: Icons.assignment,
              ),
              _buildInputField(
                label: 'Deskripsi',
                controller: controller.deskripsiController,
                icon: Icons.description,
              ),
              SizedBox(height: 20.0),
              Text(
                'Daftar Soal',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.soalList.length,
                  itemBuilder: (context, index) {
                    final soal = controller.soalList[index];
                    return _buildSoalItem(soal, index);
                  },
                ),
              ),
              SizedBox(height: 20.0),
              _buildAddSoalButton(),
              SizedBox(height: 20.0),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildSoalItem(Soal soal, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Soal ${index + 1}',
              ),
              onChanged: (value) {
                soal.soalText = value;
              },
            ),
            SizedBox(height: 10.0),
            ...List.generate(soal.pilihanList.length, (pilihanIndex) {
              return ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    labelText:
                        'Pilihan ${String.fromCharCode(65 + pilihanIndex)}',
                  ),
                  onChanged: (value) {
                    soal.pilihanList[pilihanIndex].text = value;
                  },
                ),
                leading: Radio(
                  value: pilihanIndex,
                  groupValue: soal.jawabanBenar,
                  onChanged: (value) {
                    soal.jawabanBenar = value as int;
                    controller.soalList.refresh();
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () =>
                      controller.removePilihan(index, pilihanIndex),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Tambah Pilihan'),
                  onPressed: () => controller.addPilihan(index),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Hapus Soal'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => controller.removeSoal(index),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddSoalButton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.add),
      label: Text('Tambah Soal'),
      onPressed: controller.addSoal,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        textStyle: TextStyle(fontSize: 16.0),
      ),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.save),
      label: Text('Simpan Tugas'),
      onPressed: () async {
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          },
        );
        await controller.saveTugas();
        Navigator.of(Get.context!).pop();
        _resetForm();
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        textStyle: TextStyle(fontSize: 16.0),
      ),
    );
  }

  void _resetForm() {
    controller.namaTugasController.clear();
    controller.deskripsiController.clear();
    controller.soalList.clear();
    controller.update();
  }
}
