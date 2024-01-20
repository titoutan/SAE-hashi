package body TypeCase is

   -- retourne la valeur du Type_TypeCase t
   function ValeurTypeCase (t : in Type_TypeCase) return Integer is
   begin
      return Integer(t);
   end ValeurTypeCase;

   -- retourne VRAI si t est une NOEUD et FAUX sinon
   function EstIle (t : in Type_TypeCase) return Boolean is
   begin
      return t = NOEUD;
   end EstIle;

   -- retourne VRAI si t est un ARETE et FAUX sinon
   function EstPont (t : in Type_TypeCase) return Boolean is
   begin
      return t = ARETE;
   end EstPont;

   -- retourne VRAI si t est une MER et FAUX sinon
   function EstMer (t : in Type_TypeCase) return Boolean is
   begin
      return t = MER;
   end EstMer;

end TypeCase;
