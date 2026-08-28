// gen_test.dart — generate a `SolutionTest` class from the `Solution` class in
// a LeetCode solution file.
//
// Usage:
//   dart gen_test.dart "1588. Sum of All Odd Length Subarrays.dart"
//   dart gen_test.dart --dry-run "1588. Sum of All Odd Length Subarrays.dart"
//
// It parses the single method of `class Solution` and injects (or overwrites) a
//   class SolutionTest extends Testable<RET> with ConsoleTestOutput { ... }
// right before `void main(...)` (or at end of file). `main()` is never touched.
//
// Only the clean single-method case is supported. Design-style problems
// (a class not named `Solution`, a `Solution` constructor, or more than one
// method) produce an error and leave the file unchanged.

import 'dart:io';

void main(List<String> args) {
  final positional = <String>[];
  var dryRun = false;
  for (final arg in args) {
    if (arg == '--dry-run') {
      dryRun = true;
    } else if (arg == '-h' || arg == '--help') {
      stdout.writeln('usage: dart gen_test.dart [--dry-run] "<file.dart>"');
      return;
    } else if (arg.startsWith('-')) {
      _fail('unknown option: $arg');
    } else {
      positional.add(arg);
    }
  }

  if (positional.length != 1) {
    _fail('usage: dart gen_test.dart [--dry-run] "<file.dart>"');
  }

  final file = File(positional.single);
  if (!file.existsSync()) {
    _fail('file not found: ${positional.single}');
  }

  final original = file.readAsStringSync();
  final result = generate(original);

  if (dryRun) {
    stdout.writeln('// ---- generated SolutionTest ----');
    stdout.writeln(result.block);
    stdout.writeln('// ---- resulting file ----');
    stdout.writeln(result.contents);
    return;
  }

  if (result.contents != original) {
    file.writeAsStringSync(result.contents);
  }
  stdout.writeln(
    'SolutionTest generated: Testable<${result.returnType}>  '
    'computeResult() => Solution().${result.method}('
    '${result.paramNames.join(', ')})',
  );
}

Never _fail(String message) {
  stderr.writeln(message);
  exit(1);
}

class GenResult {
  GenResult({
    required this.contents,
    required this.block,
    required this.returnType,
    required this.method,
    required this.paramNames,
  });

  final String contents;
  final String block;
  final String returnType;
  final String method;
  final List<String> paramNames;
}

GenResult generate(String source) {
  final masked = _mask(source);

  // --- locate `class Solution` ---------------------------------------------
  final classDecl = RegExp(r'\bclass\s+(\w+)\b[^{]*\{');
  final allClasses = classDecl.allMatches(masked).toList();
  final classMatch = allClasses
      .where((m) => m.group(1) == 'Solution')
      .fold<RegExpMatch?>(null, (acc, m) => acc ?? m);
  if (classMatch == null) {
    final found = allClasses.map((m) => '`${m.group(1)}`').toList();
    _fail(
      found.isEmpty
          ? 'no class declaration found in file.'
          : 'no class named `Solution` found (saw ${found.join(', ')}). '
                'Design-style problems are not supported.',
    );
  }

  final bodyOpen = classMatch.end - 1; // index of '{'
  final bodyClose = _matchBrace(masked, bodyOpen);
  if (bodyClose < 0) {
    _fail('could not find the end of `class Solution`.');
  }
  final bodyStart = bodyOpen + 1;
  final maskedBody = masked.substring(bodyStart, bodyClose);
  final rawBody = source.substring(bodyStart, bodyClose);

  // --- reject design-style `Solution` ---------------------------------------
  if (RegExp(r'\bSolution\s*\(').hasMatch(maskedBody)) {
    _fail(
      '`Solution` has a constructor — design-style problems are not supported.',
    );
  }

  // --- find member methods at brace-depth 0 -------------------------------
  final methods = _findMethods(maskedBody, rawBody);
  if (methods.isEmpty) {
    _fail('no method found in `Solution`.');
  }
  if (methods.length > 1) {
    final names = methods.map((m) => '`${m.name}`').join(', ');
    _fail(
      '`Solution` declares ${methods.length} methods ($names). This generator '
      'only supports a single-method `Solution`; reduce it to one method or '
      'write `SolutionTest` by hand.',
    );
  }

  final method = methods.single;
  final returnType = _collapseWs(method.returnType);
  if (returnType == 'void') {
    _fail('`void` return type cannot be tested via `Testable<T>`.');
  }
  final params = _parseParams(method.paramsRaw);

  // --- build the SolutionTest source -------------------------------------
  final block = _buildBlock(returnType, method.name, params);

  // --- splice into the file --------------------------------------------------
  var out = source;
  var maskedOut = masked;

  // 1. ensure `import 'testable.dart';` (check the real text — strings are
  //    blanked in the masked copy).
  if (!RegExp("import\\s+['\"]testable\\.dart['\"]").hasMatch(out)) {
    final insertAt = _importInsertionPoint(out, maskedOut);
    final before = out.substring(0, insertAt);
    final after = out.substring(insertAt);
    final lead = (before.isEmpty || before.endsWith('\n')) ? '' : '\n';
    final trail = after.startsWith('\n') ? '\n' : '\n\n';
    out = "$before${lead}import 'testable.dart';$trail$after";
    maskedOut = _mask(out);
  }

  // 2. remove an existing `class SolutionTest`
  final existing = RegExp(r'\bclass\s+SolutionTest\b').firstMatch(maskedOut);
  if (existing != null) {
    final open = maskedOut.indexOf('{', existing.end);
    final close = _matchBrace(maskedOut, open);
    if (open >= 0 && close >= 0) {
      var from = existing.start;
      var to = close + 1;
      // swallow one trailing blank line
      while (to < out.length && out[to] != '\n') {
        to++;
      }
      if (to < out.length) to++; // the newline itself
      if (to < out.length && out[to] == '\n') to++;
      // and one leading blank line
      while (from > 0 && out[from - 1] != '\n') {
        from--;
      }
      out = out.substring(0, from) + out.substring(to);
      maskedOut = _mask(out);
    }
  }

  // 3. insert the new block
  final mainMatch = RegExp(r'\bvoid\s+main\s*\(').firstMatch(maskedOut);
  if (mainMatch != null) {
    var at = mainMatch.start;
    while (at > 0 && out[at - 1] != '\n') {
      at--;
    }
    final needsGap = at > 0 && !out.substring(0, at).endsWith('\n\n');
    out =
        '${out.substring(0, at)}'
        '${needsGap ? '\n' : ''}'
        '$block\n\n'
        '${out.substring(at)}';
  } else {
    final trimmed = out.replaceFirst(RegExp(r'\s*$'), '');
    out = '$trimmed\n\n$block\n';
  }

  return GenResult(
    contents: out,
    block: block,
    returnType: returnType,
    method: method.name,
    paramNames: [for (final p in params) p.name],
  );
}

// ---------------------------------------------------------------------------
// Code generation
// ---------------------------------------------------------------------------

String _buildBlock(String returnType, String method, List<_Param> params) {
  final b = StringBuffer();
  b.writeln(
    'class SolutionTest extends Testable<$returnType> '
    'with ConsoleTestOutput {',
  );

  if (params.isEmpty) {
    b.writeln('  SolutionTest({required super.result});');
    b.writeln();
    b.writeln('  @override');
    b.writeln('  $returnType computeResult() => Solution().$method();');
    b.write('}');
    return b.toString();
  }

  for (final p in params) {
    b.writeln('  final ${p.type} ${p.name};');
  }
  b.writeln();

  // Constructor: single line when it fits in 80 cols (matches `dart format`),
  // otherwise wrapped with a trailing comma.
  final ctorParams = [
    for (final p in params) 'required this.${p.name}',
    'required super.result',
  ];
  final ctorOneLine = '  SolutionTest({${ctorParams.join(', ')}});';
  if (ctorOneLine.length <= 80) {
    b.writeln(ctorOneLine);
  } else {
    b.writeln('  SolutionTest({');
    for (final p in ctorParams) {
      b.writeln('    $p,');
    }
    b.writeln('  });');
  }
  b.writeln();
  b.writeln('  @override');

  final args = params.map((p) => p.name).join(', ');
  final oneLine = '  $returnType computeResult() => Solution().$method($args);';
  if (oneLine.length <= 80) {
    b.writeln(oneLine);
  } else {
    b.writeln('  $returnType computeResult() =>');
    b.writeln('      Solution().$method($args);');
  }
  b.write('}');
  return b.toString();
}

// ---------------------------------------------------------------------------
// Parsing helpers
// ---------------------------------------------------------------------------

class _Method {
  _Method(this.returnType, this.name, this.paramsRaw);
  final String returnType;
  final String name;
  final String paramsRaw;
}

class _Param {
  _Param(this.type, this.name);
  final String type;
  final String name;
}

/// Finds method declarations at brace-depth 0 within a class body.
/// [maskedBody] is used for scanning, [rawBody] for slicing real text.
List<_Method> _findMethods(String maskedBody, String rawBody) {
  final methods = <_Method>[];
  final decl = RegExp(r'([\w$][\w<>,.\s\[\]?$]*?)\s+([\w$]+)\s*\(');

  var searchFrom = 0;
  while (true) {
    final m = decl.firstMatch(maskedBody.substring(searchFrom));
    if (m == null) break;
    final start = searchFrom + m.start;
    final parenOpen = searchFrom + m.end - 1;

    if (_braceDepthAt(maskedBody, start) != 0) {
      searchFrom = start + 1;
      continue;
    }

    final parenClose = _matchParen(maskedBody, parenOpen);
    if (parenClose < 0) break;

    // What follows the parameter list decides if this is a real method.
    final after = maskedBody.substring(parenClose + 1).trimLeft();
    final isMethod =
        after.startsWith('{') ||
        after.startsWith('=>') ||
        after.startsWith('async') ||
        after.startsWith('sync');

    final returnType = m
        .group(1)!
        .replaceFirst(RegExp(r'^(static\s+|final\s+|const\s+)+'), '')
        .trim();
    final name = m.group(2)!;

    if (isMethod && returnType.isNotEmpty && name != 'Solution') {
      methods.add(
        _Method(returnType, name, rawBody.substring(parenOpen + 1, parenClose)),
      );
      searchFrom = parenClose + 1;
    } else {
      searchFrom = start + 1;
    }
  }
  return methods;
}

List<_Param> _parseParams(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) return const [];

  final params = <_Param>[];
  for (var piece in _splitTopLevel(trimmed, ',')) {
    piece = piece.trim();
    if (piece.isEmpty ||
        piece == '{' ||
        piece == '}' ||
        piece == '[' ||
        piece == ']') {
      continue;
    }
    // named/optional param braces & brackets
    piece = piece
        .replaceAll(RegExp(r'^[\[{]\s*'), '')
        .replaceAll(RegExp(r'\s*[\]}]$'), '')
        .trim();
    if (piece.isEmpty) continue;

    // strip leading modifiers
    piece = piece.replaceFirst(
      RegExp(r'^(required\s+|covariant\s+|final\s+)+'),
      '',
    );

    // drop default value
    final eq = _indexOfTopLevel(piece, '=');
    if (eq >= 0) piece = piece.substring(0, eq).trim();
    if (piece.isEmpty) continue;

    final nameMatch = RegExp(r'([\w$]+)\s*$').firstMatch(piece);
    if (nameMatch == null) continue;
    final name = nameMatch.group(1)!;
    final type = _collapseWs(piece.substring(0, nameMatch.start).trim());
    if (type.isEmpty) continue;
    params.add(_Param(type, name));
  }
  return params;
}

int _importInsertionPoint(String source, String masked) {
  final imports = RegExp(
    r'^\s*import\s+[^;]+;',
    multiLine: true,
  ).allMatches(masked).toList();
  if (imports.isNotEmpty) {
    var end = imports.last.end;
    if (end < source.length && source[end] == '\n') end++;
    return end;
  }
  // after the leading `//` comment block
  final lines = source.split('\n');
  var idx = 0;
  var offset = 0;
  while (idx < lines.length) {
    final line = lines[idx].trimLeft();
    if (line.startsWith('//') || line.isEmpty) {
      offset += lines[idx].length + 1;
      idx++;
    } else {
      break;
    }
  }
  return offset.clamp(0, source.length);
}

// ---------------------------------------------------------------------------
// Low-level scanning
// ---------------------------------------------------------------------------

/// Replaces every comment and string-literal body with spaces, preserving
/// length and newlines, so structural regexes never trip over `{`, `(`, `,`
/// inside comments or strings.
String _mask(String s) {
  final out = List<String>.filled(s.length, '');
  for (var i = 0; i < s.length; i++) {
    out[i] = s[i];
  }

  var i = 0;
  String blank(String ch) => ch == '\n' ? '\n' : ' ';

  while (i < s.length) {
    final ch = s[i];
    final next = i + 1 < s.length ? s[i + 1] : '';

    if (ch == '/' && next == '/') {
      while (i < s.length && s[i] != '\n') {
        out[i] = ' ';
        i++;
      }
      continue;
    }
    if (ch == '/' && next == '*') {
      out[i] = ' ';
      out[i + 1] = ' ';
      i += 2;
      while (i < s.length &&
          !(s[i] == '*' && i + 1 < s.length && s[i + 1] == '/')) {
        out[i] = blank(s[i]);
        i++;
      }
      if (i < s.length) {
        out[i] = ' ';
        if (i + 1 < s.length) out[i + 1] = ' ';
        i += 2;
      }
      continue;
    }

    if (ch == "'" || ch == '"') {
      final isRaw = i > 0 && s[i - 1] == 'r';
      final triple = s.startsWith(ch * 3, i);
      final quote = triple ? ch * 3 : ch;
      out[i] = ' ';
      if (triple) {
        out[i + 1] = ' ';
        out[i + 2] = ' ';
      }
      i += quote.length;
      while (i < s.length) {
        if (!isRaw && s[i] == r'\') {
          out[i] = ' ';
          if (i + 1 < s.length) out[i + 1] = blank(s[i + 1]);
          i += 2;
          continue;
        }
        if (s.startsWith(quote, i)) {
          for (var k = 0; k < quote.length; k++) {
            out[i + k] = ' ';
          }
          i += quote.length;
          break;
        }
        out[i] = blank(s[i]);
        i++;
      }
      continue;
    }

    i++;
  }
  return out.join();
}

int _matchBrace(String s, int open) => _matchPair(s, open, '{', '}');
int _matchParen(String s, int open) => _matchPair(s, open, '(', ')');

int _matchPair(String s, int open, String o, String c) {
  if (open < 0 || open >= s.length || s[open] != o) return -1;
  var depth = 0;
  for (var i = open; i < s.length; i++) {
    if (s[i] == o) depth++;
    if (s[i] == c) {
      depth--;
      if (depth == 0) return i;
    }
  }
  return -1;
}

int _braceDepthAt(String s, int index) {
  var depth = 0;
  for (var i = 0; i < index && i < s.length; i++) {
    if (s[i] == '{') depth++;
    if (s[i] == '}') depth--;
  }
  return depth;
}

/// Splits [s] on [sep] only where bracket depth (`()[]{}<>`) is zero.
List<String> _splitTopLevel(String s, String sep) {
  final parts = <String>[];
  final buf = StringBuffer();
  var depth = 0;
  for (var i = 0; i < s.length; i++) {
    final ch = s[i];
    if (ch == '(' || ch == '[' || ch == '{' || ch == '<') depth++;
    if (ch == ')' || ch == ']' || ch == '}' || ch == '>') depth--;
    if (ch == sep && depth == 0) {
      parts.add(buf.toString());
      buf.clear();
    } else {
      buf.write(ch);
    }
  }
  parts.add(buf.toString());
  return parts;
}

int _indexOfTopLevel(String s, String ch) {
  var depth = 0;
  for (var i = 0; i < s.length; i++) {
    final c = s[i];
    if (c == '(' || c == '[' || c == '{' || c == '<') depth++;
    if (c == ')' || c == ']' || c == '}' || c == '>') depth--;
    if (depth == 0 && c == ch) return i;
  }
  return -1;
}

String _collapseWs(String s) => s.replaceAll(RegExp(r'\s+'), ' ').trim();
