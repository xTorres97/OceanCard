enum Roles {
  // Estan ordenados de acuerdo a jerarquia
  // Nivel N1 (Mas alto)
  desarrollador("Desarrollador"),
  jefeTerminal("JefeTerminal");

  final String value;
  const Roles(this.value);
}
