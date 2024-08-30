
import 'package:flutter/material.dart';

class PersonalExpansion extends StatefulWidget {
  const PersonalExpansion({
    super.key, required this.userId, required this.id, required this.title, required this.details,
    
  });
  final int userId;
  final int id;
  final String title;
  final String details;
  @override
  PersonalExpansionState createState() => PersonalExpansionState();
}

class PersonalExpansionState extends State<PersonalExpansion> {
  bool isExpanded = true;
  bool isExpanded2 = false;

  Future<void> showTranslate() async {
    Future.delayed(const Duration(milliseconds: 1250));
    setState(() {
      isExpanded2 = !isExpanded2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(
        horizontal: isExpanded ? 25 : 0,
        vertical: 20,
      ),
      padding: const EdgeInsets.all(20),
      height: isExpanded ? 80 : MediaQuery.of(context).size.height*0.7,
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 1200),
      decoration: BoxDecoration(
        // color: const Color(0xff6F12E8),
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.all(
          Radius.circular(isExpanded ? 20 : 8),
        ),

      ),
      child: SingleChildScrollView(
        physics:
            isExpanded2 == false ? const NeverScrollableScrollPhysics() : null,
        child: Column(
          children: [
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(widget.title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  IconButton(
                    icon: isExpanded
                        ?  const Icon(
                            Icons.keyboard_arrow_down,
                            size: 27,
                      color:  Colors.green,
                          )
                        :  const Icon(
                            Icons.keyboard_arrow_up,
                            size: 27,
                      color:  Colors.green,
                          ),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                      showTranslate();
                      
                    },
                  ),
                ],
              ),
             
            ),
            isExpanded ? const SizedBox() : const SizedBox(height: 20),
            if (isExpanded2)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Expanded(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: SelectableText(
                       
                       "id :\n\n${widget.id}\n\n\nuserId :\n\n${widget.userId}\n\n\ntitle :\n\n${widget.title} \n\n\nexplain :\n\n${widget.details}",
                        
                        style: const TextStyle(
                          fontSize: 15.7,
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
          ],
        ),
      ),
    );
  }
}
