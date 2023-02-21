import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mybooknote/entities/anotation_entity.dart';
import 'package:mybooknote/entities/image_entity.dart';
import 'package:mybooknote/pages/subject_page/subject_controller.dart';

class SubjectPage extends StatelessWidget {
  final String subjectID;
  const SubjectPage({super.key, required this.subjectID});

  @override
  Widget build(BuildContext context) {
    SubjectController subjectController = SubjectController(subjectID: subjectID);
    List<ImageEntity> selectedImages = [];

    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Observer(builder: (_) {
            return AppBar(
                leading: subjectController.selectedImages.isNotEmpty
                    ? IconButton(
                        onPressed: subjectController.clearSelectedImages, icon: const Icon(Icons.close))
                    : null,
                title: Text(subjectController.selectedImages.isEmpty
                    ? 'Matéria'
                    : subjectController.selectedImages.length.toString()));
          }),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Anotações'),
                StreamBuilder(
                  stream: subjectController.snapshot,
                  builder: (_, snapshot) {
                    if (!snapshot.hasData) return const CircularProgressIndicator();
                    final docs = snapshot.data!.docs;
                    return docs.isEmpty
                        ? LottieBuilder.asset('lib/assets/animations/empty.json')
                        : SizedBox(
                            height: 300,
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final data = docs[index].data();
                                  AnotationEntity anotation = AnotationEntity.fromJson(data);
                                  return Card(
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                        onTap: () => context.push('/anotation', extra: anotation),
                                        onLongPress: () => print('bbb'),
                                        leading: const Icon(Icons.menu_book_rounded, ),
                                        title: Text(anotation.title),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(anotation.description,
                                              style: const TextStyle(overflow: TextOverflow.ellipsis),
                                              maxLines: 3,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Text(anotation.images.length.toString()),
                                                  const Icon(Icons.image, color: Colors.red,)
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        trailing: const Icon(Icons.arrow_forward_ios_rounded)),
                                  );
                                },
                                itemCount: docs.length),
                          );
                  },
                ),
              ],
            )),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () => context.push('/createAnotation/$subjectID')));
  }
}
