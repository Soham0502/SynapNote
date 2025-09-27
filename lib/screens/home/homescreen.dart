import 'package:flutter/material.dart';
import 'package:sahayak_ui/api/ai_api_service.dart';
import 'package:sahayak_ui/widgets/uihelper.dart';

class Threetab extends StatefulWidget{
  @override
  _ThreetabState createState() => _ThreetabState();
}

class _ThreetabState extends State<Threetab> {
  int _selectedIndex =0;
  final List<String> _tabs = ['Summary', 'Smart Tip', 'Quiz'];

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: 
          List.generate(_tabs.length, (index) {
            final bool isSelected = _selectedIndex == index;
            return Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: AnimatedContainer(
              duration: Duration(seconds: 3),
              margin: EdgeInsets.symmetric(horizontal: 5),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.purple.withAlpha(1) : Colors.transparent,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(_tabs[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Color(0xFF000000),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.2
                ),),
              ),),
            ));
          }),
      ),
    );
  }
}
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>{
  Color backgroundColor= Colors.grey[100]!;
  bool showsearchField =false;
  bool showinterestingfact=false;
  TextEditingController  _noteController = TextEditingController();
  bool _isLoading = false;
  List<String> _keywords = [];
  
  Null get userInputText => null;

  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _analyseNote() async {
  setState(() {
    _isLoading = true;
    _keywords = [];
  });
    try {
      final keywords = await AiApiService().getKeywords(_noteController.text);
      setState(() {
        _keywords = keywords;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _onKeywordTap(String keyword) async {
    final definition = await AiApiService().getDefinition(keyword);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(keyword),
        content: Text(definition),
      ),
    );
  }


  void changeBackgroundColor(Color color) {
    setState(() {
      backgroundColor=color;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<Color>(
            onSelected: (Color selectedColor){
              changeBackgroundColor(selectedColor);
            },
            itemBuilder: (context) =>[
            PopupMenuItem<Color>(
              value: Colors.grey[100],
              child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  radius: 10,),
                  SizedBox(width: 8,),
                  Text('Light'),
              ],
            ),),
            PopupMenuItem<Color>(
              value: Colors.black,
              child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 10,
                ),
                SizedBox(width: 8,),
                Text('Dark',
                style: TextStyle(
                  color: Colors.white
                ),),
              ],
            ),),
            PopupMenuItem<Color>(
              value: Colors.blue[50],
              child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue[50],
                  radius: 10,
                ),
                SizedBox(width: 8,),
                Text('Blueish'),
              ],
            ),),
          PopupMenuItem<Color>(
            value: Colors.purple[50],
            child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple[50],
                radius: 10,
              ),
              SizedBox(width: 8,),
              Text('Purple Tint'),
            ],
          ),),
            ],
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: -100,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xFFDBC9F5),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(500,200),
                )
              ),
            ),
          ),
          Positioned(
           top: -50,
           left: -30, 
          child:Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFFE1D9FC),
              shape: BoxShape.circle
            ),
          )),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Syn',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF7846EC),
                  ),),
                  Text('apNo',
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),),
                  Text('te',
                  style: TextStyle(
                    color: Color(0xFF3CF8D5),
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),)
                ],
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  padding: EdgeInsets.all(22),
                  height: 300,
                  width: 500,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      TextField(
                        style: TextStyle(
                          color: Colors.black
                        ),
                        controller: _noteController,
                        decoration: InputDecoration(
                          hintText: 'Start typing or paste your notes here...',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Color(0xFF9159DB),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                              color: Color(0xFF9159DB),
                              width: 2.5,
                            ),
                          ),
                          prefixIcon: Icon(Icons.note_alt,
                          color: Color(0xFF9159DB),),
                          suffixIcon: _noteController.text.isNotEmpty ? IconButton(onPressed: () => setState(() {
                            _noteController.clear();
                          }), 
                          icon: Icon(Icons.clear,
                          color: Color(0xFF000000),),) :null,
                        ),
                      ),
                      Spacer(),
                      ElevatedButton(onPressed: () {
                        _analyseNote();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9159DB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 12,
                        )
                      ), 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8,),
                          Uihelper.CustomText(text: 'Analyse', color: Colors.white, fontweight: FontWeight.w600, fontsize: 20),
                        ],
                      ),),
                      SizedBox(height: 10,),
                      if(_isLoading)
                        CircularProgressIndicator(),
                      if (_keywords.isNotEmpty)
                       Wrap(
                        spacing: 10,
                        runSpacing: 8,
                        children: 
                          _keywords.map((keyword) =>
                            ActionChip(
                              backgroundColor: Colors.white,
                              label: Text(keyword,
                              style: TextStyle(
                                color: Color(0xFF9159DB),
                                fontWeight: FontWeight.bold,
                              ),),
                              onPressed: () => _onKeywordTap(keyword),)
                          ).toList(),
                       )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 13,vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow:[ 
                    BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0,3),
                  ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Uihelper.CustomText(text: 'Concept Map', color: Color(0xFF000000), fontweight: FontWeight.bold, fontsize:18),
                        Row(
                          children: [
                            IconButton(
                            onPressed: () {
                              setState(() {
                                showsearchField = !showsearchField;
                              });
                            }, 
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 20,
                            ),
                            ),
                            IconButton(
                            onPressed: () {
                              setState(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                  content: Text('Downloading...'),
                                  duration: Duration(seconds: 3),
                                  ),
                                );
                              });
                            }, 
                            icon: Icon(
                              Icons.download,
                              color: Colors.black,
                              size: 20,
                            ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    if (showsearchField)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search Within here...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )
                          ),
                        ),),
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                      child: MindMapBuilder()
                  ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Uihelper.CustomText(text: 'Key Takeaways', color: Colors.black, fontweight: FontWeight.bold, fontsize: 15),
                          SizedBox(height: 10,),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Uihelper.CustomText(text: 'This is a summary of your notes. It highlights the key concepts and relationships between them, making it easier to understand and remember the core ideas. The AI helps structure the information logically for optimal retention.', color: Colors.grey, fontweight: FontWeight.w500, fontsize: 14),
                      if (showinterestingfact)
                      Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Uihelper.CustomText(text: '!!! Hint !!!', color: Colors.orange, fontweight: FontWeight.w500, fontsize: 15),
                      ),
                      SizedBox(height: 40,),
                      Center(
                        child: ElevatedButton(
                        onPressed: () {}, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF52CAB3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 12,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                            Icons.volume_up,
                            color: Colors.white,
                            size: 20),
                            SizedBox(width: 8,),
                            Uihelper.CustomText(text: 'Read Aloud', color: Colors.white, fontweight: FontWeight.w500, fontsize: 15),
                          ],
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),),
        ],
      ),
            ),
      ),
    ],
    ),
    );
  }
}

