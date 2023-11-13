-----------------------------------------------------------------------------
--
--  Logical unit: MprInventoryPart
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
--FUNCTION Calculate_Total_Price___(
--   MprCustomerOrderId_ IN NUMBER,
--   CustomerOrderLineId_ IN NUMBER,
--  OrderLineQuantity_ IN NUMBER,
--   OrderLinePrice_ IN NUMBER) RETURN NUMBER
--IS
--   Tot_ NUMBER;
--   
--BEGIN
--   Tot_ := OrderLineQuantity_ * OrderLinePrice_;
--   RETURN Tot_;
--END Calculate_Total_Price___;

--FUNCTION GetPartDescription(
--   PartId_ IN NUMBER) RETURN VARCHAR2;
--IS
--   
--BEGIN
--   END GetPartDescription;