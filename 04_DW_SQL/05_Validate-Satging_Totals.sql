SELECT
    SUM(GrossPay) AS GrossPay,
    SUM(BonusPay) AS BonusPay,
    SUM(DeductionAmount) AS DeductionAmount,
    SUM(NetPay) AS NetPay
FROM stg.vPayrollTransaction_Clean;