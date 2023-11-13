-----------------------------------------------------------------------------
--
--  Logical unit: MprCustomerNoOrderLine
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
FUNCTION Customer_Order_Release___ (
   rec_ IN mpr_customer_no_order_line_tab%ROWTYPE ) RETURN BOOLEAN
IS
   is_released_  VARCHAR2(20);
BEGIN

   is_released_ := Mpr_Customer_Order_API.Get_Objstate(rec_.mpr_customer_order_id);
      IF is_released_ = Mpr_Customer_Order_API.DB_RELEASED THEN 
      RETURN TRUE;
   ELSE 
      --RETURN FALSE;
      ERROR_SYS.Appl_General(lu_name_, 'Cannot be released');
   END IF;
   
END Customer_Order_Release___;


-------------------- LU SPECIFIC PRIVATE METHODS ----------------------------


-------------------- LU SPECIFIC PROTECTED METHODS --------------------------


-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------

