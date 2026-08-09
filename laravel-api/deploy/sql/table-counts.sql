\pset tuples_only on
\pset format unaligned
SELECT format(
    'SELECT %L || ''='' || count(*)::text FROM %I.%I;',
    schemaname || '.' || tablename,
    schemaname,
    tablename
)
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename
\gexec
