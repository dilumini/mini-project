-----------------------------------------------------------------------------
--
--  Logical unit: MprPartLocationQuantity
--  Component:    MPRINV
--
--  IFS Developer Studio Template Version 3.0
--
--  Date    Sign    History
--  ------  ------  ---------------------------------------------------------
-----------------------------------------------------------------------------

layer Core;

-------------------- PUBLIC DECLARATIONS ------------------------------------


-------------------- PRIVATE DECLARATIONS -----------------------------------


-------------------- LU SPECIFIC IMPLEMENTATION METHODS ---------------------


-------------------- LU SPECIFIC PRIVATE METHODS ----------------------------


-------------------- LU SPECIFIC PROTECTED METHODS --------------------------


-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
PROCEDURE Update_Quantity(
   location_id_ IN NUMBER,
   part_id_     IN NUMBER,
   quantity_    IN NUMBER)
IS
   rec_ mpr_part_location_quantity_tab%ROWTYPE;
   objid_ VARCHAR2(2000);
   objversion_ VARCHAR2(2000);
   attr_ VARCHAR2(2000);
BEGIN
   IF Check_Exist___(part_id_,location_id_) THEN
      rec_ := Lock_By_Keys___(part_id_,location_id_);
      rec_.quantity := rec_.quantity+quantity_;
      Update___(objid_, rec_, rec_, attr_, objversion_, TRUE);
   ELSE
      rec_.part_id := part_id_;
      rec_.location_id := location_id_;
      rec_.quantity := quantity_;
      New___(rec_);
   END IF;
END Update_Quantity;


PROCEDURE Issue_Part_From_Inventory (
   part_no_  IN NUMBER, quantity_ IN NUMBER)
IS
   location_no_ NUMBER;
location_quantity_ NUMBER;
available_quantity_ NUMBER;
issue_quantity_ NUMBER;
CURSOR Issue_Available_Quantitiy IS
      SELECT LOCATION_ID, QUANTITY FROM MPR_PART_LOCATION_QUANTITY_TAB
      WHERE PART_ID = part_no_ ORDER BY QUANTITY ASC;
INSUFFICIENT_QUANTITY EXCEPTION;
BEGIN
issue_quantity_ := quantity_;
--   SELECT LOCATION_NO, QUANTITY INTO location_no_, available_quantity_
--   FROM MPR_INVENTORY_QUANTITIES_TAB
--   WHERE QUANTITY=(
--      SELECT MIN(QUANTITY)FROM MPR_INVENTORY_QUANTITIES_TAB 
--      WHERE PART_NO = part_no_) AND PART_NO = part_no_;
   SELECT SUM(QUANTITY) INTO available_quantity_ FROM MPR_PART_LOCATION_QUANTITY_TAB
   WHERE PART_ID = part_no_;
IF available_quantity_ < issue_quantity_ THEN 
   RAISE INSUFFICIENT_QUANTITY;
END IF;
OPEN Issue_Available_Quantitiy;
LOOP
FETCH Issue_Available_Quantitiy INTO location_no_, location_quantity_;
EXIT WHEN Issue_Available_Quantitiy%NOTFOUND;
IF issue_quantity_ >= location_quantity_ THEN
   issue_quantity_ := issue_quantity_ - location_quantity_ ;
      DELETE FROM MPR_PART_LOCATION_QUANTITY_TAB 
      WHERE PART_ID = part_no_ AND LOCATION_ID = location_no_;
ELSE
      UPDATE MPR_PART_LOCATION_QUANTITY_TAB SET QUANTITY = QUANTITY - issue_quantity_
      WHERE PART_ID = part_no_ AND LOCATION_ID = location_no_ ;
   EXIT;   
END IF;
END LOOP;
CLOSE Issue_Available_Quantitiy;

EXCEPTION
   WHEN INSUFFICIENT_QUANTITY THEN
      DBMS_OUTPUT.PUT_LINE('Insufficient Quantity in Inventory!');   
END Issue_Part_From_Inventory;


