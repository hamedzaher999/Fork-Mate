int getNextAvailableKey(List key) {
  int id = 0;
  while (key.contains(id)) {
    id++;
  }
  return id;
}
