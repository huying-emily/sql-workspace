-- Function: clone_schema(text, text, boolean)

-- DROP FUNCTION clone_schema(text, text, boolean);

CREATE OR REPLACE FUNCTION clone_schema(
	source_schema text, 
	dest_schema text,
	include_recs boolean)
  RETURNS void AS
$BODY$

-- This function will clone all tables, data, sequences, indexes, foreign keys from any existing schema to a new one

DECLARE
  src_oid          oid;
  tbl_oid          oid;
  func_oid         oid;
  object           text;
  buffer           text;
  srctbl           text;
  default_         text;
  column_          text;
  qry              text;
  dest_qry         text;
  v_def            text;
  constraint_name_ text;
  constraint_def_  text;
  seqval           bigint;
  sq_last_value    bigint;
  sq_max_value     bigint;
  sq_start_value   bigint;
  sq_increment_by  bigint;
  sq_min_value     bigint;
  sq_cache_value   bigint;
  sq_log_cnt       bigint;
  sq_is_called     boolean;
  sq_is_cycled     boolean;
  sq_cycled        char(10);

 
 BEGIN
  
  -- Check that source_schema exists
  SELECT oid INTO src_oid
    FROM pg_namespace
   WHERE nspname = source_schema;
  IF NOT FOUND
    THEN 
    RAISE NOTICE 'source schema % does not exist!', source_schema;
    RETURN ;
  END IF;

  -- Check that dest_schema does not yet exist, if exists then drops
  PERFORM nspname 
    FROM pg_namespace
   WHERE nspname = dest_schema;
  IF FOUND
    THEN 
    RAISE NOTICE 'dest schema % already exists!', dest_schema;
   	EXECUTE 'DROP SCHEMA ' || dest_schema || ' CASCADE';
  END IF;

 
  EXECUTE 'CREATE SCHEMA ' || quote_ident(dest_schema) ;

 
  -- Clones sequence
  FOR object IN
    SELECT sequence_name::text 
    FROM information_schema.SEQUENCES 
    WHERE sequence_schema = quote_ident(source_schema)
  LOOP
    EXECUTE 'CREATE SEQUENCE ' || quote_ident(dest_schema) || '.' || quote_ident(object);
    srctbl := quote_ident(source_schema) || '.' || quote_ident(object);

    EXECUTE 'SELECT last_value, log_cnt, is_called 
              FROM ' || quote_ident(source_schema) || '.' || quote_ident(object) || ';' 
              INTO sq_last_value, sq_log_cnt, sq_is_called ; 

    buffer := quote_ident(dest_schema) || '.' || quote_ident(object);
    IF include_recs 
        THEN
            EXECUTE 'SELECT setval( ''' || buffer || ''', ' || sq_last_value || ', ' || sq_is_called || ');' ; 
    ELSE
            EXECUTE 'SELECT setval( ''' || buffer || ''', ' || sq_start_value || ', ' || sq_is_called || ');' ;
    END IF;
   
  END LOOP;

 
  -- Clones tables, columns, data and default value
  FOR object IN
    SELECT table_name::text 
    FROM information_schema.TABLES 
    WHERE table_schema = quote_ident(source_schema)
    
  LOOP
    buffer := dest_schema || '.' || quote_ident(object);
    EXECUTE 'CREATE TABLE ' || buffer || ' (LIKE ' || quote_ident(source_schema) || '.' || quote_ident(object) 
   		|| ' INCLUDING ALL)';
    
    -- Insert records from source table
   	IF include_recs 
      THEN   
      EXECUTE 'INSERT INTO ' || buffer || ' SELECT * FROM ' || quote_ident(source_schema) || '.' || quote_ident(object) || ';';
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
  END LOOP;

 
  -- reiterate tables and create foreign keys
  FOR object IN
    SELECT table_name::text FROM information_schema.TABLES WHERE table_schema = source_schema
  LOOP
    buffer := dest_schema || '.' || object;
 
    -- create foreign keys
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
  END LOOP;
 

  -- Clones views 
  FOR object IN
    SELECT table_name::text,
           view_definition 
      FROM information_schema.views
     WHERE table_schema = quote_ident(source_schema)

  LOOP
    buffer := quote_ident(dest_schema) || '.' || quote_ident(object);
    SELECT view_definition INTO v_def
      FROM information_schema.views
     WHERE table_schema = quote_ident(source_schema)
       AND table_name = quote_ident(object);
     
    EXECUTE 'CREATE OR REPLACE VIEW ' || buffer || ' AS ' || v_def || ';' ;

  END LOOP;
 
  -- Create functions 
  FOR func_oid IN
    SELECT oid
      FROM pg_proc 
     WHERE pronamespace = src_oid

  LOOP      
    SELECT pg_get_functiondef(func_oid) INTO qry;
    SELECT replace(qry, source_schema, dest_schema) INTO dest_qry;
    EXECUTE dest_qry;

  END LOOP;

  RETURN; 
   
 
END;

$BODY$  
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION clone_schema(text, text, boolean)
  OWNER TO pipeline;
COMMENT ON FUNCTION clone_schema(text, text, boolean) IS 'Automatic backup source schema.';







-- SAMPLE CALL:
-- SELECT clone_schema('public', 'new_schema', TRUE);
select clone_schema('source','replicate_source', TRUE)


-- DROP SCHEMA replicate_source CASCADE;


select clone_schema('star','replicate_star', TRUE)




