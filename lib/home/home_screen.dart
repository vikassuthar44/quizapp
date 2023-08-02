import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/home/category_data.dart';
import 'package:quiz_app/question/questions_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Category> categoryList;

  @override
  void initState() {
    super.initState();
    getData();
    categoryList = [];
  }

  void getData() async {
    FirebaseFirestore firebase = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> snapshot = await firebase.collection("category").get();
    List<Category> cats= snapshot.docs
        .map((docSnapshot) => Category.fromDocumentSnapshot(docSnapshot))
        .toList();

    for (var i = 0; i < cats.length; i++) {
      setState(() {
        categoryList.add(Category(
            name: cats[i].name,
            bg: cats[i].bg,
            docId: cats[i].docId
        ));
      });
      print("catName ${cats[i]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.75)),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade200,
      ),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              color: Colors.blue.shade200,
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              margin: const EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                itemCount: categoryList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return QuestionsScreen(categoryName: categoryList[index].name, docId: categoryList[index].docId.path.toString(),);
                      }));
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(categoryList[index].bg),
                                fit: BoxFit.fill),
                            ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              categoryList[index].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black.withOpacity(0.75),
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
