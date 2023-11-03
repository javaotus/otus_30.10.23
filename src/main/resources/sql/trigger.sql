-- auto-generated definition
CREATE TRIGGER update_balance_account
    AFTER INSERT OR DELETE OR UPDATE
    ON lesson_25.account
    FOR EACH ROW
EXECUTE PROCEDURE lesson_25.recalculate_balance();

CREATE TRIGGER update_balance_account_bank_customer
    AFTER INSERT OR DELETE OR UPDATE
    ON lesson_25.account_bank_customer
    FOR EACH ROW
EXECUTE PROCEDURE lesson_25.recalculate_balance();