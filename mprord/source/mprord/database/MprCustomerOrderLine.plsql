-----------------------------------------------------------------------------
--
--  Logical unit: MprCustomerOrderLine
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
   rec_ IN mpr_customer_order_line_tab%ROWTYPE ) RETURN BOOLEAN
IS
   is_released2_  VARCHAR2(20);
BEGIN
--    SELECT ROWSTATE INTO 
   --is_released2_ 
   --FROM Mpr_Customer_Order_Tab
   --WHERE  Mpr_Customer_Order_Id = rec_.mpr_customer_order_id AND ROWSTATE = 'Released'--;
--   IF is_released2_ = 'Released' THEN 
--      RETURN TRUE;
--   ELSE 
--      RETURN FALSE;
--   END IF;
   is_released2_ := Mpr_Customer_Order_API.Get_Objstate(rec_.mpr_customer_order_id);
      IF is_released2_ = Mpr_Customer_Order_API.DB_RELEASED THEN 
      RETURN TRUE;
   ELSE 
      --RETURN FALSE;
      ERROR_SYS.Appl_General(lu_name_, 'Cannot be released');
   END IF;
   

END Customer_Order_Release___;

PROCEDURE Update_Inventory_Quantity___ (
   rec_  IN OUT NOCOPY mpr_customer_order_line_tab%ROWTYPE,
   attr_ IN OUT NOCOPY VARCHAR2 )
IS
   
BEGIN
   Mpr_Part_Location_Quantity_API.Issue_Part_From_Inventory(rec_.part_id,rec_.order_line_quantity);
   -- NO IMPLEMENTATION WRITTEN YET
END Update_Inventory_Quantity___;



-------------------- LU SPECIFIC PRIVATE METHODS ----------------------------


-------------------- LU SPECIFIC PROTECTED METHODS --------------------------


-------------------- LU SPECIFIC PUBLIC METHODS -----------------------------
--The reason of writing this method as a public metho is by writing this as a public method
--the client side also can access this method then. this method is accessed by  Calculate_Total_Amount___.
--in managesales .plsvc file calculate totalamount method call this calculate sub total price method which is inside in this plsql. only public methods can access from clientside
FUNCTION Calculate_Sub_Total_Price(
   MprCustomerOrderId_  IN NUMBER,
   CustomerOrderLineId_ IN NUMBER,
   OrderLineQuantity_   IN NUMBER,
   OrderLinePrice_      IN NUMBER) RETURN NUMBER
IS
   Tot_ NUMBER;
   
BEGIN
   Tot_ := OrderLineQuantity_ * OrderLinePrice_;
   RETURN Tot_;
END Calculate_Sub_Total_Price;


FUNCTION Seq_Co_Id (
   mpr_customer_order_id_ IN NUMBER) RETURN NUMBER
IS
   customer_order_line_id_ NUMBER := 0;
      ConcatValue_ NUMBER;
BEGIN
   LOOP
      customer_order_line_id_ := TRN_CO_LINE_ID_SEQ.NEXTVAL;
      EXIT WHEN NOT (MPR_CUSTOMER_ORDER_LINE_API.Exists(mpr_customer_order_id_, customer_order_line_id_));
   END LOOP; 
     ConcatValue_ := TO_NUMBER(TO_CHAR(mpr_customer_order_id_) || '.' || TO_CHAR(customer_order_line_id_));
RETURN ConcatValue_;
END Seq_Co_Id;

