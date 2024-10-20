class Usage {
  static void printUsage() {
    print('''
Usage: contact <commande> [arguments]

Commandes disponibles:
  -add <nom> <prenom> <telephone> <email>
  -display
  -update <numero> <nom> <prenom> <numero> <email>
  -remove <number>
 
  ''');
  }
}
