import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_soal_controller.dart';
import '../../../data/models/soal_model.dart';

class AddSoalView extends GetView<AddSoalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff008DDA),
        title: Text('Tambah Soal Siswa',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
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
              const SizedBox(height: 20.0),
              const Text(
                'Daftar Soal',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.soalList.length,
                  itemBuilder: (context, index) {
                    final soal = controller.soalList[index];
                    return _buildSoalItem(soal, index);
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              _buildAddSoalButton(),
              const SizedBox(height: 20.0),
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
      margin: const EdgeInsets.symmetric(vertical: 10.0),
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
            const SizedBox(height: 10.0),
            ...List.generate(soal.pilihanList.length, (pilihanIndex) {
              return ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    labelText: 'Pilihan ${String.fromCharCode(65 + pilihanIndex)}',
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
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => controller.removePilihan(index, pilihanIndex),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.add, color: Color(0xff008DDA)),
                  onPressed: () => controller.addPilihan(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
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
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff008DDA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: controller.addSoal,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Tambah Soal',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff008DDA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () async {
          showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
          await controller.saveTugas();
          Navigator.of(Get.context!).pop();
          _resetForm();
        },
        child: const Text(
          'Simpan Tugas',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
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
