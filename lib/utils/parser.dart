import 'package:petitparser/petitparser.dart';

// トークン定義
// class Tokenizer extends GrammarDefinition {
//   Tokenizer() : super(const _TokenizerDefinition());
// }

class TokenizerDefinition extends GrammarDefinition {
  const TokenizerDefinition();

  @override
  Parser start() => ref0(token).star();

  Parser token() => ref0(backslashNumber);

  Parser backslashNumber() =>
      (char('¥') & ref0(number) & ref0(whitespace1)).map((values) {
        final numberString = values[1].replaceFirst(RegExp(r'^0+'), '');
        return numberString;
      });

  Parser number() => digit().plus().flatten();

  Parser whitespace1() => whitespace().plus().flatten();
}

class TokenizerDefinition2 extends GrammarDefinition {
  const TokenizerDefinition2();

  @override
  Parser start() => ref0(token); //.star();

  Parser token() => ref0(backslashNumber);

  Parser backslashNumber() =>
      (char('¥') & ref0(number) & ref0(whitespace1) | char("円").optional())
          .map((values) {
        final numberString = values[1].replaceFirst(RegExp(r'^0+'), '');
        return numberString;
      });

  Parser number() => digit().plus().flatten();

  Parser whitespace1() => whitespace().plus().flatten();
}

parser(String input) {
  const tokenizer = TokenizerDefinition();
  final parser = tokenizer.build();
  final result = parser.parse(input);

  // パーサのテスト
  switch (result) {
    case Success(value: final value):
      print('解析成功: $value');
    case Failure(
        message: final message,
        position: final position,
        buffer: final buffer
      ):
      print('解析失敗: $message');
      print('位置: $position');
      print('バッファ: $buffer');
    default:
      print('解析失敗');
  }
  print(result.value);
  String res = result.value.toString();
  return res;
}

simpleParser(String input) {
  final parser = const TokenizerDefinition2().build();
  final result = parser.parse('¥124円 45we6');
  // パーサのテスト
  switch (result) {
    case Success(value: final value):
      print('解析成功: $value');
    case Failure(
        message: final message,
        position: final position,
        buffer: final buffer
      ):
      print('解析失敗: $message');
      print('位置: $position');
      print('バッファ: $buffer');
    default:
      print('解析失敗');
  }
  print(result.value);
  String res = result.value.toString();
  return res;
}
