class Usage {
  static void printUsage() {
    print('''
Usage: contact <commande> [arguments]

Commandes disponibles:
  -add <first name> <last name> <number> <email>
  -display
  -search <number>
  -update <number>
  -remove <number>
  ''');
  }
}
