with Orientation; use Orientation;
with Pont; use Pont;

package body Ile is

   -- construit une ile ayant la valeur v
   -- nécessite 0 < v <= 8
   -- lève l'exception VALEUR_NOEUD_INVALIDE si 0 <= v ou v > 8
   function ConstruireIle (v : in Integer) return Type_Ile is
   begin
      if v <= 0 or v > 8 then
         raise VALEUR_ILE_INVALIDE;
      else
         return (v => v);
      end if;
   end ConstruireIle;

   -- retourne la valence de l'île i
   function ObtenirValeur (i : in Type_Ile) return Integer is
   begin
      return i.v;
   end ObtenirValeur;

   -- retourne VRAI si tous les ponts de l'île i sont trouvés
   -- et FAUX sinon
   function EstIleComplete (i : in Type_Ile) return Boolean is
   begin
      return i.v = 0;
   end EstIleComplete;

   -- modifie l'île i en lui soustrayant la valeur p
   -- nécessite 1 <= p <= 2
   -- nécessite obtenirvaleur(i)-p >= 0
   -- lève l'exception VALEUR_PONT_INVALIDE si 0 <= v ou v > 8
   -- lève l'exception PONT_IMPOSSIBLE si 0 <= v ou v > 8
   function ModifierIle (i : in Type_Ile; p : in Integer) return Type_Ile is
   begin
      if p < 1 or p > 2 then
         raise VALEUR_PONT_INVALIDE;
      elsif i.v - p < 0 then
         raise PONT_IMPOSSIBLE;
      else
         return ( v => i.v- p);
      end if;
   end ModifierIle;

end Ile;
