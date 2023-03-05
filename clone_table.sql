-- Function: clone_table(text, text)

-- DROP FUNCTION clone_table(text, text);

CREATE OR REPLACE FUNCTION clone_table(
    source_schema text,
    source_table text,
    dest_schema text,
    dest_table text,
    include_recs boolean)
  RETURNS void AS
$BODY$

--  This function will clone all columns and data from any existing table to a new one
-- SAMPLE CALL:
-- SELECT clone_table('source', 'hk_data_gov', 'playground', 'backup_hk_data_gov', TRUE);

DECLARE
  object           text;
  buffer           text;
  default_         text;
  column_          text;
  constraint_name_ text;
  constraint_def_  text;
  index_name_      text;

BEGIN

buffer := quote_ident(dest_schema) || '.' || quote_ident(dest_table);
EXECUTE 'CREATE TABLE ' || buffer || ' (LIKE ' || quote_ident(source_schema) || '.' || quote_ident(source_table)
   		|| ' INCLUDING ALL)';


-- Insert records from source table
IF include_recs
    THEN
    EXECUTE 'INSERT INTO ' || buffer || ' SELECT * FROM ' || quote_ident(source_schema) || '.' || quote_ident(source_table) || ';';
END IF;

FOR column_, default_ IN
    SELECT column_name::text,
      	   REPLACE(column_default::text, source_schema, dest_schema)
    FROM information_schema.COLUMNS
    WHERE table_schema = dest_schema
    AND table_name = object
    AND column_default LIKE 'nextval(%' || quote_ident(source_schema) || '%::regclass)'
LOOP
    EXECUTE 'ALTER TABLE ' || buffer || ' ALTER COLUMN ' || column_ || ' SET DEFAULT ' || default_;
END LOOP;

-- Create foreign keys
FOR constraint_name_, constraint_def_ IN
    SELECT conname::text, REPLACE(pg_get_constraintdef(pg_constraint.oid),
    source_schema||'.', dest_schema||'.') FROM pg_constraint
    INNER JOIN pg_class ON conrelid=pg_class.oid INNER JOIN pg_namespace ON
    pg_namespace.oid=pg_class.relnamespace WHERE contype='f'
    and relname=object and nspname=source_schema
LOOP
    EXECUTE 'ALTER TABLE '|| buffer
    ||' ADD CONSTRAINT '|| constraint_name_ ||' '|| constraint_def_;
END LOOP;


END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION clone_table(text, text, text, text, boolean)
  OWNER TO pipeline;
COMMENT ON FUNCTION clone_table(text, text, text, text, boolean) IS 'Clone table to backup.';




SELECT clone_table('source', 'hk_data_gov', 'playground', 'hk_data_gov_111', TRUE)



