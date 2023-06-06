import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:property_app/constants/colors.dart';
import 'package:property_app/controllers/image_controller.dart';
import 'package:property_app/main.dart';

class ItemImagesScreen extends StatefulWidget {
  final String itemId;

  const ItemImagesScreen({Key? key, required this.itemId}) : super(key: key);

  @override
  _ItemImagesScreenState createState() => _ItemImagesScreenState();
}

class _ItemImagesScreenState extends State<ItemImagesScreen> {
  List<String> _imagePaths = [];
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
    _loadItemImages();
  }

  Future<void> _loadItemImages() async {
    try {
      List<String> itemImages = await _getItemImages(widget.itemId);
      for (String imageUrl in itemImages) {
        String fileName = imageUrl.split('/').last;
        Directory appDir = await getApplicationDocumentsDirectory();
        String filePath = '${appDir.path}/$fileName';

        try {
          File file = File(filePath);
          if (!file.existsSync()) {
            firebase_storage.Reference ref =
                firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl);
            await ref.writeToFile(file);
          }
          setState(() {
            _imagePaths.add(filePath);
          });
        } catch (e) {
          // Lidar com erros ao fazer o download das imagens
          print('Erro ao fazer o download da imagem: $e');
        }
      }
    } catch (e) {
      // Lidar com erros ao carregar as imagens do Firestore
      print('Erro ao carregar imagens: $e');
    }
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _imagePaths
            .addAll(pickedFiles.map((pickedFile) => pickedFile.path).toList());
      });
    }
  }

  Future<void> _uploadImages() async {
    setState(() {
      _uploading = true; // Indicar que o envio está em andamento
    });

    for (String imagePath in _imagePaths) {
      try {
        File file = File(imagePath);
        String fileName = imagePath.split('/').last;
        String ref = 'images/${widget.itemId}/$fileName';
        await firebase_storage.FirebaseStorage.instance.ref(ref).putFile(file);
      } on firebase_storage.FirebaseException catch (e) {
        throw Exception('Erro no upload: ${e.code}');
      }
    }

    setState(() {
      _uploading = false; // Indicar que o envio foi concluído
    });

    Navigator.of(context).pop(); // Voltar à tela anterior
  }

  Future<List<String>> _getItemImages(String itemId) {
    Future<List<String>> imageUrls = getItemImages(itemId);
    return imageUrls;
  }

  void _openImageOverlay(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            width: double.maxFinite,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.contain,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fechar o overlay
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Imagens'),
        backgroundColor: CustomColor.customBlue, // Cor de fundo da app bar
        actions: [
          IconButton(
            onPressed: _uploadImages,
            icon: const Icon(Icons.save), // Ícone de salvar
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _pickImages,
            style: ElevatedButton.styleFrom(
              primary: CustomColor.customBlue, // Cor de fundo do botão
              onPrimary: Colors.white, // Cor do texto do botão
            ),
            child: const Text('Escolher Imagens'),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 300,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Número de colunas
                  crossAxisSpacing:
                      8.0, // Espaçamento horizontal entre as células
                  mainAxisSpacing: 8.0, // Espaçamento vertical entre as células
                ),
                itemCount: _imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _openImageOverlay(context, _imagePaths[index]);
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(_imagePaths[index]),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                _imagePaths.removeAt(
                                    index); // Excluir a imagem da lista
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          if (_uploading) // Exibir indicador de status durante o envio
            CircularProgressIndicator()
          else // Exibir botão de envio
            ElevatedButton(
              onPressed: _uploadImages,
              style: ElevatedButton.styleFrom(
                primary: CustomColor.customBlue, // Cor de fundo do botão
                onPrimary: Colors.white, // Cor do texto do botão
              ),
              child: const Text('Enviar Imagens'),
            ),
        ],
      ),
    );
  }
}
