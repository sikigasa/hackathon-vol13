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
  Parser start() => ref0(token).star();

  Parser token() =>
      ref0(validBackslashNumber) |
      ref0(invalidBackslashNumber) |
      ref0(whitespace1);

  // 有効なバックスラッシュ後の数字を解析
  Parser validBackslashNumber() =>
      (char('\\') & ref0(nonZeroNumber) & ref0(whitespaceOptional))
          .map((values) {
        return values[1];
      });

  // 無効なバックスラッシュ後の数字を解析
  Parser invalidBackslashNumber() =>
      (char('\\') & ref0(zeroStartNumber) & ref0(whitespaceOptional))
          .map((_) => '');

  // 先頭が0ではない数字
  Parser nonZeroNumber() =>
      digit().plus().flatten().where((value) => !value.startsWith('0'));

  // 先頭が0である数字
  Parser zeroStartNumber() =>
      digit().plus().flatten().where((value) => value.startsWith('0'));

  Parser whitespace1() => whitespace().plus().flatten();

  Parser whitespaceOptional() => whitespace().star().flatten();
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
  final result = parser.parse('\\12345 \\1242222円 \\126円 45we6 asdwa234');
  // パーサのテスト
  switch (result) {
    case Success(value: final value):
      print('解析成功: $value');
    // final tokens = result.value.where((token) => token.isNotEmpty).toList();
    // print('解析された数字: $tokens');
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
