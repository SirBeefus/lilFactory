import 'items.dart';

class Inventory extends CardObject{
  Inventory({this.item});

  List<Item> item;

  String printItemCount(){
    List<Item> all = item + itemInput + itemOutput;
    List<String> allS = new List<String>();
    for(Item i in all){
      allS.add(i.toString());
    }
    Map<String, int> map = new Map<String, int>();
    for(String s in allS){
      map.putIfAbsent(s, ()=> 0);
      if(map.containsKey(s)){
        map[s] = map[s] + 1;
      }
    }
    return map.isNotEmpty ? map.toString() : '';
  }
}