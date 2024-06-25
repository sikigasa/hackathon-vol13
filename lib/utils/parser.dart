import 'package:petitparser/core.dart';
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
      (char('¥') & ref0(number) & ref0(whitespace)).map((values) {
        final numberString = values[1].replaceFirst(RegExp(r'^0+'), '');
        return numberString;
      });

  Parser number() => digit().plus().flatten();

  Parser whitespace() => whitespace().plus().flatten();
}

// トークンタイプ
enum TokenType { number, operator, identifier, parenthesis, whitespace }

// トークンクラス
class Token {
  final TokenType type;
  final String value;

  Token(this.type, this.value);

  @override
  String toString() => 'Token(type: $type, value: $value)';
}

parser(String input) {
  const tokenizer = TokenizerDefinition();
  final parser = tokenizer.build();
  final result = parser.parse(input);

  // パーサのテスト
  switch (result) {
    case Success(value: final value):
      print('解析成功: $value'); // 出力: 解析成功: 12345
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
  return result.value;
}
