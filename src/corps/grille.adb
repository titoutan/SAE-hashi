package body Grille is

   function ConstruireGrille (nbl : in Integer ; nbc : in Integer) return Type_Grille is
      G : Type_Grille;
   begin
      if nbl <= 1 or nbl > TAILLE_MAX or nbc <= 1 or nbc > TAILLE_MAX then
         raise TAILLE_INVALIDE;
      end if;

      G.nbl := nbl;
      G.nbc := nbc;

      for L in 1 .. nbl loop
         for C in 1 .. nbc loop
            G.g(L, C) := ConstruireCase(ConstruireCoordonnees(L, C));
         end loop;
      end loop;

      return G;
   end ConstruireGrille;

   function nbLignes (G : Type_Grille) return Integer is
   begin
      return G.nbl;
   end nbLignes;

   function nbColonnes (G : Type_Grille) return Integer is
   begin
      return G.nbc;
   end nbColonnes;

   function estGrilleVide (G : in Type_Grille) return Boolean is
   begin
      for L in 1 .. G.nbl loop
         for C in 1 .. G.nbc loop
            if estIle(ObtenirTypeCase(G.g(L, C))) then
               return False;
            end if;
         end loop;
      end loop;
      return True;
   end estGrilleVide;

   function estComplete (G : in Type_Grille) return Boolean is
   begin
      for L in 1 .. G.nbl loop
         for C in 1 .. G.nbc loop
            if estIle(ObtenirTypeCase(G.g(L, C))) and then not estIleComplete(ObtenirIle(G.g(L, C))) then
               return False;
            end if;
         end loop;
      end loop;
      return not estGrilleVide(G);
   end estComplete;

   function nbIle (G : in Type_Grille) return Integer is
      Count : Integer := 0;
   begin
      for L in 1 .. G.nbl loop
         for C in 1 .. G.nbc loop
            if estIle(ObtenirTypeCase(G.g(L, C))) then
               Count := Count + 1;
            end if;
         end loop;
      end loop;
      return Count;
   end nbIle;

   function nbIleCompletes (G : in Type_Grille) return Integer is
      Count : Integer := 0;
   begin
      for L in 1 .. G.nbl loop
         for C in 1 .. G.nbc loop
            if estIle(ObtenirTypeCase(G.g(L, C))) and then estIleComplete(ObtenirIle(G.g(L, C))) then
               Count := Count + 1;
            end if;
         end loop;
      end loop;
      return Count;
   end nbIleCompletes;

   function ObtenirCase (G : in Type_Grille ; Co : in Type_Coordonnee) return Type_CaseHashi is
   begin
      return G.g(ObtenirLigne(Co), ObtenirColonne(Co));
   end ObtenirCase;

   function aUnSuivant (G : in Type_Grille; C : in Type_CaseHashi ; O : Type_Orientation) return Boolean is

   begin
      case ValeurOrientation(O) is
      when -1 =>
         return ObtenirLigne(ObtenirCoordonnee(C)) > 1;
      when 1 =>
         return ObtenirLigne(ObtenirCoordonnee(C)) < G.nbl;
      when -2 =>
         return ObtenirColonne(ObtenirCoordonnee(C)) < G.nbc;
      when 2 =>
         return ObtenirColonne(ObtenirCoordonnee(C)) > 1;
      when others =>
         return False;
      end case;
   end aUnSuivant;

   function obtenirSuivant (G : in Type_Grille; C : in Type_CaseHashi ; O : Type_Orientation) return Type_CaseHashi is
      CoSuivant : Type_Coordonnee;
   begin
      if aUnSuivant(G, C, O) then
         case ValeurOrientation(O) is
         when -1 =>
            CoSuivant := ConstruireCoordonnees(ObtenirLigne(ObtenirCoordonnee(C)) - 1, ObtenirColonne(ObtenirCoordonnee(C)));
         when 1 =>
            CoSuivant := ConstruireCoordonnees(ObtenirLigne(ObtenirCoordonnee(C)) + 1, ObtenirColonne(ObtenirCoordonnee(C)));
         when -2 =>
            CoSuivant := ConstruireCoordonnees(ObtenirLigne(ObtenirCoordonnee(C)), ObtenirColonne(ObtenirCoordonnee(C)) + 1);
         when 2 =>
            CoSuivant := ConstruireCoordonnees(ObtenirLigne(ObtenirCoordonnee(C)), ObtenirColonne(ObtenirCoordonnee(C)) - 1);
         when others =>
            raise PAS_DE_SUIVANT;
         end case;
         return ObtenirCase(G, CoSuivant);
      else
         raise PAS_DE_SUIVANT;
      end if;
   end obtenirSuivant;

   procedure modifierCase (G : in out Type_Grille; C : in Type_CaseHashi) is
   begin
      G.g(ObtenirLigne(ObtenirCoordonnee(C)), ObtenirColonne(ObtenirCoordonnee(C))) := C;
   end modifierCase;

end Grille;
