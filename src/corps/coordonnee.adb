package body Coordonnee is

   -- retourne la valeur d'une Coordonnee
   function ConstruireCoordonnees
     (Ligne, Colonne : in Integer) return Type_Coordonnee is
   begin
      return (Ligne => Ligne, Colonne => Colonne);
   end ConstruireCoordonnees;

   -- retourne le numero de la ligne dans lequel se trouve la coordonnee c
   function ObtenirLigne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Ligne;
   end ObtenirLigne;

   -- retourne le numero de la colonne dans lequel se trouve la coordonnee c
   function ObtenirColonne (C : in Type_Coordonnee) return Integer is
   begin
      return C.Colonne;
   end ObtenirColonne;

end Coordonnee;
