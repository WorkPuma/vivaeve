select t.table_schema,
       t.table_name,
       c.column_name,
       c.ordinal_position,
       c.data_type,
       case
           when c.numeric_precision is not null
               then c.numeric_precision
           when c.character_maximum_length is not null
               then c.character_maximum_length
           end as max_length,
       c.numeric_scale,
       c.is_identity,
       c.is_nullable
    from information_schema.tables t
             inner join information_schema.columns c on
                c.table_schema = t.table_schema and c.table_name = t.table_name
    where table_type = 'BASE TABLE'
    order by table_schema,
             table_name,
             column_name;
