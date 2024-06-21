import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_tugas_controller.dart';

class EditTugasView extends GetView<EditTugasController> {
  const EditTugasView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff008DDA),
        title: const Text(
          'Edit Tugas',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: controller.namaTugasController,
                decoration: InputDecoration(
                  labelText: 'Nama Tugas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.deskripsiController,
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              _buildAddSoalButton(),
              const SizedBox(height: 20),
              _buildSaveButton(),
            ],
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
              controller: TextEditingController(text: soal.soalText)
                ..selection =
                    TextSelection.collapsed(offset: soal.soalText.length),
            ),
            const SizedBox(height: 10.0),
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
                  controller: TextEditingController(
                    text: soal.pilihanList[pilihanIndex].text,
                  )..selection = TextSelection.collapsed(
                      offset: soal.pilihanList[pilihanIndex].text.length),
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
                  onPressed: () =>
                      controller.removePilihan(index, pilihanIndex),
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
    return Center(
      child: ElevatedButton.icon(
        onPressed: () => controller.addSoal(),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Soal'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff008DDA),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          await controller.updateTugas();
        },
        icon: const Icon(Icons.save),
        label: const Text('Simpan'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff008DDA),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
