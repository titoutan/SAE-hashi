with Ada.Text_IO; use Ada.Text_IO;
with TypeCase; use TypeCase;
with Ile; use Ile;
with Coordonnee; use Coordonnee;
with Pont; use Pont;
-- Ajoutez les déclarations nécessaires ici

package body Resolution_Hashi is

   procedure rechercherUneIleCible
     (G      : in Type_Grille; C : in Type_CaseHashi; O : in Type_Orientation;
      Trouve :    out Boolean; ile : out Type_CaseHashi)
   is
      caseCourante : Type_CaseHashi; -- case courante
      fini         : Boolean;
      Suivant      : Type_CaseHashi;
      TypeSuivant  : Type_TypeCase;
   begin
      --  initialisations
      fini := False;
      -- recherche du successeur
      caseCourante := C;
      while not fini and aUnSuivant (G, caseCourante, O) loop
         -- enregistrement du suivant
         Suivant     := obtenirSuivant (G, caseCourante, O);
         TypeSuivant := ObtenirTypeCase (Suivant);
         -- si c'est la mer je continue
         if estMer (TypeSuivant) then
            caseCourante := Suivant;
         else
            -- si c'est une ile
            if estIle (TypeSuivant) then
               -- si elle est complete c'est fini
               if estIleComplete (ObtenirIle (Suivant)) then
                  Trouve := False;
                  fini   := True;
               else
                  -- si elle n'est pas complete c'est OK
                  Trouve := True;
                  ile    := Suivant;
                  fini   := True;
               end if;
               -- si c'est un pont
            else
               if estPont (TypeSuivant) then
                  -- s'il est de valeur 2 c'est mort
                  if ObtenirPont (Suivant) = DEUX then
                     Trouve := False;
                     fini   := True;
                     -- il est de valeur 1
                  else
                     -- si son predecesseur est
                     -- de valeur 1 on continue
                     if (estPont (ObtenirTypeCase (caseCourante))
                         and then ObtenirPont (caseCourante) = UN)
                       or (EstIle(ObtenirTypeCase(CaseCourante)))
                     then
                        caseCourante := Suivant;
                     else
                        -- a moins que ce soit un croisement dans ce cas on
                        -- arrete
                        Trouve := False;
                        fini   := True;
                     end if;
                  end if;
               end if;
            end if;
         end if;
      end loop;
      -- N'a pas de suivant
      if not aUnSuivant (G, caseCourante, O) then
         Trouve := False;
      end if;
   end rechercherUneIleCible;

   procedure construireTableauSuccesseurs
     (G : in Type_Grille; C : Type_CaseHashi; s : out Type_Tab_Successeurs;
      NbPonts : out Integer; NbNoeuds : out Integer) is
      ileNord: Type_CaseHashi;
      ileSud: Type_CaseHashi;
      ileEst: Type_CaseHashi;
      ileOuest: Type_CaseHashi;
      trouve: Boolean;
   begin
      NbPonts := 0;
      NbNoeuds := 0;
      rechercherUneIleCible(G,C,NORD,trouve,ileNord);
      if trouve then
         NbPonts := NbPonts + Integer'Max(ObtenirValeur(ObtenirIle(ileNord)),2);
         NbNoeuds := NbNoeuds + 1;
      else
         ileNord := construireCase(ConstruireCoordonnees(0,0));
      end if;
      rechercherUneIleCible(G,C,SUD,trouve,ileSud);
      if trouve then
         NbPonts := NbPonts + Integer'Max(ObtenirValeur(ObtenirIle(ileSud)),2);
         NbNoeuds := NbNoeuds + 1;
      else
         ileSud := construireCase(ConstruireCoordonnees(0,0));
      end if;

      rechercherUneIleCible(G,C,EST,trouve,ileEst);
      if trouve then
         NbPonts := NbPonts + Integer'Max(ObtenirValeur(ObtenirIle(ileEst)),2);
         NbNoeuds := NbNoeuds + 1;
      else
         ileEst := construireCase(ConstruireCoordonnees(0,0));
      end if;
      rechercherUneIleCible(G,C,OUEST,trouve,ileOuest);
      if trouve then
         NbPonts := NbPonts + Integer'Max(ObtenirValeur(ObtenirIle(ileOuest)),2);
         NbNoeuds := NbNoeuds + 1;
      else
         ileOuest := construireCase(ConstruireCoordonnees(0,0));
      end if;

      s := (NORD => ileNord, SUD => ileSud, EST => ileEst, OUEST => ileOuest);
   end construireTableauSuccesseurs;

   procedure construireLeChemin
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      cible : in out Type_CaseHashi; pont : in Type_Pont;
      o     : in     Type_Orientation) is
      debut: Integer;
      fin: Integer;
      stable: Integer;
   begin
      case ValeurOrientation(o) is
      when -1 =>
         debut := ObtenirLigne(ObtenirCoordonnee(cible));
         fin := ObtenirLigne(ObtenirCoordonnee(source));
         stable := ObtenirColonne(ObtenirCoordonnee(source));
         for i in debut..fin loop
            G := modifierCase(G,modifierPont(ObtenirCase(G,ConstruireCoordonnees(i, stable)),pont));
         end loop;
      when 1 =>
         debut := ObtenirLigne(ObtenirCoordonnee(source));
         fin := ObtenirLigne(ObtenirCoordonnee(cible));
         stable := ObtenirColonne(ObtenirCoordonnee(source));
         for i in debut..fin loop
            G := modifierCase(G,modifierPont(ObtenirCase(G,ConstruireCoordonnees(i, stable)),pont));
         end loop;
      when -2 =>
         debut := ObtenirColonne(ObtenirCoordonnee(source));
         fin := ObtenirColonne(ObtenirCoordonnee(cible));
         stable := ObtenirLigne(ObtenirCoordonnee(source));
         for i in debut..fin loop
            G := modifierCase(G,modifierPont(ObtenirCase(G,ConstruireCoordonnees(stable, i)),pont));
         end loop;
      when 2 =>
         debut := ObtenirColonne(ObtenirCoordonnee(cible));
         fin := ObtenirColonne(ObtenirCoordonnee(source));
         stable := ObtenirLigne(ObtenirCoordonnee(source));
         for i in debut..fin loop
            G := modifierCase(G,modifierPont(ObtenirCase(G,ConstruireCoordonnees(stable, i)),pont));
         end loop;
      when others =>
         raise PAS_D_ILE_CIBLE;
      end case;
      G := modifierCase(G,modifierIle(source, ConstruireIle(v => ObtenirValeur(pont))));
      G := modifierCase(G,modifierIle(cible, ConstruireIle(v => ObtenirValeur(pont))));
   end construireLeChemin;

   procedure ResoudreHashi (G : in out Type_Grille; Trouve : out Boolean) is
   begin
      -- Implémentation de la résolution Hashi
      -- ...

      -- Exemple de sortie (à adapter selon l'implémentation réelle)
      Trouve := False;
   end ResoudreHashi;

end Resolution_Hashi;
