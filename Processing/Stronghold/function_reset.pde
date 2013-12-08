PrintWriter p1s;
PrintWriter p2s;
PrintWriter p1r;
PrintWriter p2r;

void reset() {
  // Reset castle health
  castlehealth = castlehealthinit;
  
  // Reset repetition counts in text files
  resetFile(p1s, "player1shoot.txt");
  resetFile(p2s, "player2shoot.txt");
  resetFile(p1r, "player1repair.txt");
  resetFile(p2r, "player2repair.txt");

  // Reset skeletons
  for (int i = 0; i < skeletons.length; i++) {
    skeletons[i].reset();
  }
    
  // Set game into 'start' mode / show 'start' screen
  mode = 's';
}

void resetFile(PrintWriter file, String filename) {
  file = createWriter(filename);
  file.print("0");
  file.flush();
  file.close();
}
  