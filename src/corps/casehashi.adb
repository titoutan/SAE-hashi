with Coordonnee; use Coordonnee;
with Ile;        use Ile;
with Pont;       use Pont;
with TypeCase;   use TypeCase;

package body CaseHashi is

   -- construit une case dont la valeur est la mer
   function ConstruireCase (C : in Type_Coordonnee) return Type_CaseHashi is
   begin
      return (C => C, T => MER, I => ConstruireIle(0), P => UN);
   end ConstruireCase;

   -- Retourne le type de la case c : MER, ILE ou PONT
   function ObtenirTypeCase (C : in Type_CaseHashi) return Type_TypeCase is
   begin
      return C.T;
   end ObtenirTypeCase;

   -- Retourne le type de la case c
   function ObtenirCoordonnee (C : in Type_CaseHashi) return Type_Coordonnee is
   begin
      return C.C;
   end ObtenirCoordonnee;

   -- Retourne l'ile de la case c nécessite que le type de la case soit ILE
   -- lève l'exception TYPE_INCOMPATIBLE si le type de la case n'est pas une
   -- ile
   function ObtenirIle (C : in Type_CaseHashi) return Type_Ile is
   begin
      if not EstIle(C.T) then
         raise TYPE_INCOMPATIBLE;
      else
         return C.I;
      end if;
   end ObtenirIle;

   -- Retourne le pont de la case c nécessite que le type de la case soit
   -- PONT lève l'exception TYPE_INCOMPATIBLE si le type de la case n'est
   -- pas un pont
   function ObtenirPont (C : in Type_CaseHashi) return Type_Pont is
   begin
      if not EstPont(C.T) then
         raise TYPE_INCOMPATIBLE;
      else
         return C.P;
      end if;
   end ObtenirPont;

   -----------------
   -- modifierIle --
   -----------------

   function modifierIle
     (C : in Type_CaseHashi; I : in Type_Ile) return Type_CaseHashi
   is
      NewC : Type_CaseHashi;
   begin
      if EstPont(C.T) then
         raise TYPE_INCOMPATIBLE;
      end if;
      NewC.c := ObtenirCoordonnee(C);
      NewC.T := NOEUD;
      NewC.I := I;
      return NewC;
   end modifierIle;

   ------------------
   -- modifierPont --
   ------------------

   function modifierPont
     (C : in Type_CaseHashi; p : in Type_Pont) return Type_CaseHashi
   is
      NewC : Type_CaseHashi;
   begin
      if EstIle(C.T)  then
         raise TYPE_INCOMPATIBLE;
      end if;
      NewC.c := ObtenirCoordonnee(C);
      NewC.T := ARETE;
      if EstPont(C.T) and then ObtenirPont(C)= UN then
         NewC.p:= DEUX;
      else
         NewC.p := p;
      end if;
      return NewC;
   end modifierPont;


   -- retourne VRAI si les cases C1 et C2 sont égales et FAUX sinon
   function "=" (C1 : in Type_CaseHashi; C2 : in Type_CaseHashi) return Boolean is
   begin
      return C1.C = C2.C and C1.T = C2.T and C1.I = C2.I and C1.P = C2.P;
   end "=";

end CaseHashi;
