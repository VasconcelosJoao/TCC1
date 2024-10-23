import 'dart:collection';

class Interpreter {
  late final HashMap<String, String> wordsInPortugueseToEnglish;

  HashMap<String, String> init() {
    wordsInPortugueseToEnglish = HashMap<String, String>();
    wordsInPortugueseToEnglish["SELECIONE"] = "SELECT";
    wordsInPortugueseToEnglish["ATUALIZAR"] = "UPDATE";
    wordsInPortugueseToEnglish["DELETAR"] = "DELETE";
    wordsInPortugueseToEnglish["INSERIR"] = "INSERT INTO";
    wordsInPortugueseToEnglish["CRIAR"] = "CREATE";
    wordsInPortugueseToEnglish["ALTERAR"] = "ALTER";
    wordsInPortugueseToEnglish["BD"] = "DATABASE";
    wordsInPortugueseToEnglish["DERRUBAR"] = "DROP";
    wordsInPortugueseToEnglish["INDICE"] = "INDEX";
    wordsInPortugueseToEnglish["PRIMARIA"] = "PRIMARY KEY";
    wordsInPortugueseToEnglish["ESTRANGEIRA"] = "FOREIGN KEY";
    wordsInPortugueseToEnglish["NULO"] = "NULL";
    wordsInPortugueseToEnglish["TABELA"] = "TABLE";
    wordsInPortugueseToEnglish["NAO"] = "NOT";
    wordsInPortugueseToEnglish["AUTO"] = "AUTO";
    wordsInPortugueseToEnglish["INCREMENTO"] = "INCREMENT";
    wordsInPortugueseToEnglish["VALORES"] = "VALUES";
    wordsInPortugueseToEnglish["DE"] = "FROM";
    wordsInPortugueseToEnglish["ONDE"] = "WHERE";
    wordsInPortugueseToEnglish["UNIR"] = "JOIN";
    wordsInPortugueseToEnglish["POR"] = "BY";
    wordsInPortugueseToEnglish["AGRUPAR"] = "GROUP";
    wordsInPortugueseToEnglish["TER"] = "HAVING";
    wordsInPortugueseToEnglish["ORDEM"] = "ORDER";
    wordsInPortugueseToEnglish["DISTINTO"] = "DISTINCT";
    wordsInPortugueseToEnglish["LIMITAR"] = "LIMIT";
    wordsInPortugueseToEnglish["SOMAR"] = "SUM";
    wordsInPortugueseToEnglish["CONTAR"] = "COUNT";
    wordsInPortugueseToEnglish["MEDIA"] = "AVG";
    wordsInPortugueseToEnglish["MAXIMO"] = "MAX";
    wordsInPortugueseToEnglish["MINIMO"] = "MIN";
    wordsInPortugueseToEnglish["COMO"] = "LIKE";
    wordsInPortugueseToEnglish["ENTRE"] = "BETWEEN";
    wordsInPortugueseToEnglish["EM"] = "IN";
    wordsInPortugueseToEnglish["EXISTE"] = "EXISTS";
    wordsInPortugueseToEnglish["UNIAO"] = "UNION";
    wordsInPortugueseToEnglish["TOTAL"] = "ALL";

    return wordsInPortugueseToEnglish;
  }

  void interpret(String code) {
    // Ordenar as chaves por comprimento decrescente
    var sortedKeys = wordsInPortugueseToEnglish.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    // Substituir frases compostas primeiro
    for (var key in sortedKeys) {
      code = code.replaceAll(
          RegExp(r'\b' + key + r'\b'), wordsInPortugueseToEnglish[key]!);
    }

    // Imprimir o código traduzido
    print(code);
  }
}
