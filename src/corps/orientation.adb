pragma Ada_2012;
package body Orientation is

   -----------------------
   -- ValeurOrientation --
   -----------------------

   function ValeurOrientation
     (o : in Type_Orientation) return Integer is
   begin
      case o is
      when NORD =>
         return -1;
      when SUD =>
         return 1;
      when EST =>
         return -2;
      when OUEST =>
         return 2;
      when others =>
         -- Vous pouvez traiter le cas par défaut ici, si nécessaire
         return 0; -- Par exemple, retourner 0 pour une valeur non reconnue
   end case;
   end;

   ------------------------
   -- orientationInverse --
   ------------------------

   function orientationInverse
     (o : in Type_Orientation) return Type_Orientation is
   begin
   case o is
      when NORD =>
         return SUD;
      when SUD =>
         return NORD;
      when EST =>
         return OUEST;
      when OUEST =>
         return EST;
      when others =>
         -- Vous pouvez traiter le cas par défaut ici, si nécessaire
         return o; -- Par exemple, retourner la même orientation pour une valeur non reconnue
      end case;
   end;



end Orientation;
