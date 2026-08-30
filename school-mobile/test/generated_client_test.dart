// Verifies the generated OpenAPI client against a JSON fixture shaped like a
// real /payments response. Importing the generated barrel also type-checks the
// whole generated tree, which analysis_options.yaml excludes from the linter.
//
// No network call is made here: only deserialization of a literal fixture.
import 'package:flutter_test/flutter_test.dart';
import 'package:school_mobile/generated/school_mobile.dart';

/// A single payment as the API serialises it: decimals arrive as strings, and
/// optional columns arrive as explicit nulls.
const Map<String, dynamic> paymentFixture = <String, dynamic>{
  'id': 4211,
  'invoice_id': 913,
  'amount': '1500.50',
  'method': 'cash',
  'reference': null,
  'recorded_by': null,
  'paid_at': '2026-08-31T14:05:00.000Z',
  'note': 'دفعة أولى',
  'created_at': '2026-08-31T14:05:01.000Z',
  'updated_at': null,
  'idempotency_key': null,
  'idempotency_payload_hash': null,
  'payment_receipt_id': 77,
  'status': 'posted',
  'reversed_at': null,
  'school_id': 1,
};

void main() {
  group('generated Payment model', () {
    test('deserializes a payment fixture', () {
      final payment =
          standardSerializers.deserializeWith(Payment.serializer, paymentFixture)!;

      expect(payment.id, 4211);
      expect(payment.invoiceId, 913);
      expect(payment.method, 'cash');
      expect(payment.status, 'posted');
      expect(payment.schoolId, 1);
      expect(payment.paidAt, DateTime.utc(2026, 8, 31, 14, 5));
    });

    test('keeps the money field as an exact decimal string', () {
      final payment =
          standardSerializers.deserializeWith(Payment.serializer, paymentFixture)!;

      // amount is `type: string` in the contract. It must never be parsed into
      // a double, which would silently round money values.
      expect(payment.amount, isA<String>());
      expect(payment.amount, '1500.50');

      final roundTripped = standardSerializers.serializeWith(
        Payment.serializer,
        payment,
      )! as Map<Object?, Object?>;
      expect(roundTripped['amount'], '1500.50');
    });

    test('maps nullable fields to null and keeps populated ones', () {
      final payment =
          standardSerializers.deserializeWith(Payment.serializer, paymentFixture)!;

      // `reference` and `recorded_by` are `[string, 'null']` / `[integer,
      // 'null']` in the OpenAPI 3.1 contract.
      expect(payment.reference, isNull);
      expect(payment.recordedBy, isNull);
      expect(payment.updatedAt, isNull);
      expect(payment.reversedAt, isNull);

      // A nullable field carrying a value still round-trips, Arabic included.
      expect(payment.note, 'دفعة أولى');
      expect(payment.paymentReceiptId, 77);
    });

    test('rejects a payload missing a required field', () {
      final invalid = Map<String, dynamic>.from(paymentFixture)..remove('amount');

      expect(
        () => standardSerializers.deserializeWith(Payment.serializer, invalid),
        throwsA(isA<Error>()),
      );
    });
  });
}
