with Ada.Text_IO; use Ada.Text_IO;
-- Ajoutez les d�clarations n�cessaires ici

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
   begin
      -- Impl�mentation de la construction du tableau des successeurs
      -- ...

      -- Exemple de sortie (� adapter selon l'impl�mentation r�elle)
      s := (others => (others => <>));
      NbPonts := 0;
      NbNoeuds := 0;
   end construireTableauSuccesseurs;

   procedure construireLeChemin
     (G     : in out Type_Grille; source : in out Type_CaseHashi;
      cible : in out Type_CaseHashi; pont : in Type_Pont;
      o     : in     Type_Orientation) is
   begin
      -- Impl�mentation de la construction du chemin
      -- ...

      -- Exemple d'op�rations (� adapter selon l'impl�mentation r�elle)
      Put_Line("Construction du chemin...");
   end construireLeChemin;

   procedure ResoudreHashi (G : in out Type_Grille; Trouve : out Boolean) is
   begin
      -- Impl�mentation de la r�solution Hashi
      -- ...

      -- Exemple de sortie (� adapter selon l'impl�mentation r�elle)
      Trouve := False;
   end ResoudreHashi;

end Resolution_Hashi;