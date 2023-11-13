-----------------------------------------------------------------------------
--
--  Logical unit: MprCustomerOrder
--  Component:    MPRORD
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
FUNCTION Not_Delivered___ (
   rec_ IN mpr_customer_order_tab%ROWTYPE ) RETURN BOOLEAN
IS
   --is_delivered1_   VARCHAR2(20);
  -- is_delivered2_   VARCHAR2(20);
  Count_ NUMBER;
  NoCount_ NUMBER;
BEGIN
   SELECT COUNT(ROWSTATE) INTO Count_
   FROM Mpr_Customer_Order_Line_Tab
   WHERE  Mpr_Customer_Order_Id = rec_.mpr_customer_order_id AND ROWSTATE = 'Delivered';
   SELECT COUNT(ROWSTATE) INTO NoCount_
   FROM Mpr_Customer_No_Order_Line_Tab
   WHERE  Mpr_Customer_Order_Id = rec_.mpr_customer_order_id AND ROWSTATE = 'Delivered';
--   -- NO IMPLEMENTATION WRITTEN YET
   IF Count_ > 0 OR NoCount_ > 0 THEN
      RETURN FALSE;
   ELSE
      RETURN TRUE;
   END IF;
   
   --SELECT ROWSTATE INTO is_delivered1_
--   FROM Mpr_Customer_Order_Line_Tab
--   WHERE Mpr_Customer_Order_Id = rec_.mpr_customer_order_id AND ROWSTATE = 'Delivered';
   
   --SELECT COUNT(ROWSTATE) INTO is_delivered2_
--   FROM Mpr_Customer_No_Order_Line_Tab
--   WHERE Mpr_Customer_Order_Id = rec_.mpr_customer_order_id AND ROWSTATE = 'Delivered';
   
   
--   IF (is_delivered1_ = 'Delivered')  THEN 
--      RETURN FALSE;
--   
--   ELSE
--      RETURN TRUE;
--   END IF;
  
   
   -- NO IMPLEMENTATION WRITTEN YET
END Not_Delivered___;


-------------------- LU SPECIFIC PRIVATE METHODS ----------------------------


-------------------- LU SPECIFIC PROTECTED METHODS --------------------------


-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------

