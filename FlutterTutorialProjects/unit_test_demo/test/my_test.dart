import 'package:flutter_test/flutter_test.dart';
import 'package:unit_test_demo/main.dart';

void main(){
    test('Testing findSqaure function', (){
      expect(MyApp().findSquare(2), 4);
    });
    test('Testing function 2', (){
      expect(MyHomePage().createState().testFunction(), 100);
    });
}