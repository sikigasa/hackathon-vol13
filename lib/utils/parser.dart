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

  Parser token() =>
      ref0(number) |
      ref0(operator) |
      ref0(identifier) |
      ref0(parenthesis) |
      ref0(whitespace);

  // 特定の文字「a」を解析するパーサ
  // final specificChar = char('合計');

  // 一つ以上の数字を解析するパーサ
  // final digits = digit().plus();

  // 「a」の後に続く数字を解析するパーサを定義
  // final parser = specificChar.seq(digits).map((values) {
  //   return values[1].join(); // 数字の部分を抽出
  // });
  Parser totalSum() => char('合計');
  //string('合計').trim().map((value) => Token(TokenType.identifier, value));

  Parser number() => digit()
      .plus()
      .flatten()
      .trim()
      .map((value) => Token(TokenType.number, value));

  Parser operator() => (char('+') | char('-') | char('*') | char('/'))
      .flatten()
      .trim()
      .map((value) => Token(TokenType.operator, value));

  Parser identifier() => (letter() & word().star())
      .flatten()
      .trim()
      .map((value) => Token(TokenType.identifier, value));

  Parser parenthesis() => (char('(') | char(')'))
      .flatten()
      .trim()
      .map((value) => Token(TokenType.parenthesis, value));

  // Parser whitespace() =>
  //     whitespace().plus().map((value) => Token(TokenType.whitespace, value));
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
  final tokenizer = TokenizerDefinition();
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
