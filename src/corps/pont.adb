package body Pont is

   -- retourne la valeur du Arete p
   function ObtenirValeur (p : in Type_Pont) return Integer is
   begin
      return Integer(p);
   end ObtenirValeur;

   -- retourne VRAI si la valeur du Arete p est POTENTIEL et FAUX sinon
   function EstPotentiel (p : in Type_Pont) return Boolean is
   begin
      return p /= DEUX;
   end EstPotentiel;

   -- retourne VRAI si l'Arete a la valeur UN ou DEUX
   -- leve l'exception PONT_IMPOSSIBLE si valeur(a)=IMPOSSIBLE
   function EstInstancie (p : in Type_Pont) return Boolean is
   begin
      return p /= POTENTIEL;
   end EstInstancie;

   function "=" (p1: in Type_Pont; p2: in Type_Pont) return boolean is
   begin
      return ObtenirValeur(p1) = ObtenirValeur(p2);
   end "=";
end Pont;
