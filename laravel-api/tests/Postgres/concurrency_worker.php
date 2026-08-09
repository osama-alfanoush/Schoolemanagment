<?php

$pdo = new PDO(getenv('PG_CONCURRENCY_DSN'), getenv('PG_CONCURRENCY_USER'), getenv('PG_CONCURRENCY_PASSWORD'), [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
]);
[$script, $operation] = $argv;
usleep(400000);

try {
    if ($operation === 'grade') {
        $statement = $pdo->prepare('UPDATE grades SET score = ?, version = version + 1, updated_at = NOW() WHERE id = ? AND version = 1');
        $statement->execute([(float) $argv[3], (int) $argv[2]]);
        exit($statement->rowCount() === 1 ? 0 : 10);
    }
    if ($operation === 'attendance') {
        $statement = $pdo->prepare("INSERT INTO attendance_records (school_id,student_user_id,class_room_id,date,status,marked_by,scope_key,version,created_at,updated_at) VALUES (?,?,?,?,?,?,'daily',1,NOW(),NOW()) ON CONFLICT (student_user_id,date,scope_key) DO UPDATE SET status=EXCLUDED.status, marked_by=EXCLUDED.marked_by, version=attendance_records.version+1, updated_at=NOW()");
        $statement->execute([(int) $argv[2], (int) $argv[3], (int) $argv[4], $argv[5], $argv[6], (int) $argv[7]]);
        exit(0);
    }
    if ($operation === 'enrollment') {
        $statement = $pdo->prepare("INSERT INTO student_enrollments (student_user_id,school_id,academic_year_id,class_room_id,start_date,end_date,status,entry_type,version,created_at,updated_at) VALUES (?,?,?,?,?,?,'active','new',1,NOW(),NOW())");
        $statement->execute(array_map(fn ($value) => $value === 'NULL' ? null : $value, array_slice($argv, 2, 6)));
        exit(0);
    }
    if ($operation === 'payroll') {
        $statement = $pdo->prepare("INSERT INTO payroll_records (school_id,staff_user_id,payroll_run_id,year,month,base_salary,net_pay,status,created_at,updated_at) VALUES (?,?,?,?,?,1000,1000,'draft',NOW(),NOW())");
        $statement->execute(array_slice($argv, 2, 5));
        exit(0);
    }
    exit(20);
} catch (PDOException $exception) {
    fwrite(STDERR, $exception->getCode().': '.$exception->getMessage().PHP_EOL);
    exit(in_array($exception->getCode(), ['23P01', '23505'], true) ? 10 : 20);
}
