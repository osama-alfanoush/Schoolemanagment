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
    if ($operation === 'payment_intent') {
        // Five phones, one idempotency key. The unique index decides, not the
        // application: a check-then-insert can be passed by all five.
        [, , $schoolId, $guardianId, $studentId, $installmentId, $key, $reference] = $argv;
        $statement = $pdo->prepare("INSERT INTO mobile_payment_intents (school_id,idempotency_key,request_hash,reference,guardian_user_id,student_user_id,installment_id,amount_minor,currency,decimals,status,created_at,updated_at) VALUES (?,?,?,?,?,?,?,150000,'JOD',3,'created',NOW(),NOW())");
        $statement->execute([
            (int) $schoolId,
            $key,
            str_repeat('a', 64),
            $reference,
            (int) $guardianId,
            (int) $studentId,
            (int) $installmentId,
        ]);
        exit(0);
    }
    if ($operation === 'grade_batch') {
        // One teacher, one queued column, five drain attempts. The key is
        // claimed before a single mark is written, so the index decides which
        // attempt gets to write and the other four roll back untouched.
        [, , $schoolId, $teacherId, $classRoomId, $subjectId, $key] = $argv;
        $statement = $pdo->prepare("INSERT INTO teacher_grade_batches (idempotency_key,school_id,class_room_id,subject_id,submitted_by,payload_hash,record_count,result,created_at,updated_at) VALUES (?,?,?,?,?,?,1,'[]',NOW(),NOW())");
        $statement->execute([
            $key,
            (int) $schoolId,
            (int) $classRoomId,
            (int) $subjectId,
            (int) $teacherId,
            str_repeat('b', 64),
        ]);
        exit(0);
    }
    exit(20);
} catch (PDOException $exception) {
    fwrite(STDERR, $exception->getCode().': '.$exception->getMessage().PHP_EOL);
    exit(in_array($exception->getCode(), ['23P01', '23505'], true) ? 10 : 20);
}
