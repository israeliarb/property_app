import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:property_app/constants/colors.dart';
import 'package:property_app/constants/spacing_sizes.dart';
import 'package:property_app/controllers/image_controller.dart';
import 'package:property_app/main.dart';

class ItemImagesScreen extends StatefulWidget {
  final String itemId;

  const ItemImagesScreen({Key? key, required this.itemId}) : super(key: key);

  @override
  _ItemImagesScreenState createState() => _ItemImagesScreenState();
}

class _ItemImagesScreenState extends State<ItemImagesScreen> {
  List<String> _uploadedImages = [];
  List<String> _downloadedImages = [];
  bool _uploading = false;
  bool? _deleteConfirmed;

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
            _downloadedImages.add(filePath);
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
        _uploadedImages
            .addAll(pickedFiles.map((pickedFile) => pickedFile.path).toList());
      });
    }
  }

  Future<void> _uploadImages() async {
    setState(() {
      _uploading = true; // Indicar que o envio está em andamento
    });

    // Fazer upload das imagens selecionadas para upload
    for (String imagePath in _uploadedImages) {
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

  Future<bool> _checkImageExists(String ref) async {
    try {
      final storageRef = firebase_storage.FirebaseStorage.instance.ref(ref);
      final result = await storageRef.getDownloadURL();
      return true; // A imagem existe no Firestore
    } catch (e) {
      return false; // A imagem não existe no Firestore
    }
  }

  Future<List<String>> _getItemImages(String itemId) {
    Future<List<String>> imageUrls = getItemImages(itemId);
    return imageUrls;
  }

  Future<void> _deleteImage(String imagePath) async {
    if (_uploadedImages.contains(imagePath)) {
      setState(() {
        _uploadedImages.remove(imagePath);
      });
    } else if (_downloadedImages.contains(imagePath)) {
      setState(() {
        _downloadedImages.remove(imagePath);
      });
    } else {
      return; // Se o caminho da imagem não for encontrado, retornar sem excluir
    }

    final localFile = File(imagePath);
    final firebaseStorage = firebase_storage.FirebaseStorage.instance;

    try {
      // Verificar se a imagem está armazenada localmente
      if (await localFile.exists()) {
        await localFile.delete();
        print('Imagem local excluída com sucesso: $imagePath');
      }
    } catch (e) {
      print('Erro ao excluir imagem local: $e');
    }

    try {
      // Verificar se a imagem está armazenada no Firestore
      if (_downloadedImages.contains(imagePath)) {
        final ref = firebaseStorage.refFromURL(imagePath);
        await ref.delete();
        print('Imagem excluída do Firestore com sucesso: $imagePath');
      }
    } catch (e) {
      print('Erro ao excluir imagem do Firestore: $e');
    }
  }

  Future<bool?> _showDeleteConfirmationDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text('Deseja excluir esta imagem?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirma a exclusão
              },
              child: const Text('Sim'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancela a exclusão
              },
              child: const Text('Não'),
            ),
          ],
        );
      },
    );
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
            TextButton(
              onPressed: () async {
                bool confirmed =
                    (await _showDeleteConfirmationDialog()) as bool;
                if (confirmed) {
                  _deleteImage(imagePath);
                  Navigator.of(context).pop(); // Fechar o overlay após excluir
                }
              },
              child: const Text('Excluir'),
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
                itemCount: _uploadedImages.length + _downloadedImages.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index < _downloadedImages.length) {
                    // Imagem carregada do Firestore
                    return GestureDetector(
                      onTap: () {
                        _openImageOverlay(context, _downloadedImages[index]);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              File(_downloadedImages[index]),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: () async {
                                bool confirmDelete =
                                    await _showDeleteConfirmationDialog() ??
                                        false;
                                if (confirmDelete) {
                                  await _deleteImage(_downloadedImages[index]);
                                  setState(() {
                                    _downloadedImages.removeAt(index);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    // Imagem selecionada para upload
                    int uploadIndex = index - _downloadedImages.length;
                    return GestureDetector(
                      onTap: () {
                        _openImageOverlay(
                            context, _uploadedImages[uploadIndex]);
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              File(_uploadedImages[uploadIndex]),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.close, color: Colors.white),
                              onPressed: () async {
                                bool confirmDelete =
                                    await _showDeleteConfirmationDialog() ??
                                        false;
                                if (confirmDelete) {
                                  await _deleteImage(_downloadedImages[index]);
                                  setState(() {
                                    _downloadedImages.removeAt(index);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
