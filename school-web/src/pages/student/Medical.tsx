import { useTranslation } from "react-i18next";
import { useQuery } from "@tanstack/react-query";
import { Student } from "@/lib/api";

export default function StudentMedical() {
  const { t } = useTranslation();

  const { data: records, isLoading } = useQuery({
    queryKey: ["student-medical-records"],
    queryFn: () => Student.myMedicalRecords(),
  });

  const recordItems = Array.isArray(records) ? records : (records as any)?.data ?? [];
  const record = recordItems.length > 0 ? recordItems[0] : (records as any);

  return (
    <div className="space-y-6">
      <h1 className="font-display text-2xl font-bold text-ink-dark tracking-tight">My Medical Records</h1>

      {isLoading ? (
        <div className="p-8 text-center text-muted-foreground">Loading medical records…</div>
      ) : !record ? (
        <div className="p-8 text-center border rounded-md text-muted-foreground">No medical records on file.</div>
      ) : (
        <div className="space-y-4">
          {/* Health Info Card */}
          <div className="rounded-lg border bg-card p-6">
            <h2 className="text-lg font-semibold mb-4">Health Information</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <div className="text-sm text-muted-foreground">Blood Type</div>
                <div className="font-medium text-lg">{record.blood_type ?? "Not recorded"}</div>
              </div>
              <div>
                <div className="text-sm text-muted-foreground">Allergies</div>
                <div className="font-medium text-lg text-red-600">{record.allergies ?? "None reported"}</div>
              </div>
              <div>
                <div className="text-sm text-muted-foreground">Chronic Conditions</div>
                <div className="font-medium">{record.chronic_conditions ?? record.condition ?? "None"}</div>
              </div>
              <div>
                <div className="text-sm text-muted-foreground">Emergency Contact</div>
                <div className="font-medium">{record.emergency_contact ?? "Not provided"}</div>
              </div>
            </div>
            {record.notes && (
              <div className="mt-4 pt-4 border-t">
                <div className="text-sm text-muted-foreground">Notes</div>
                <p className="mt-1 text-sm">{record.notes}</p>
              </div>
            )}
          </div>

          {/* Medications */}
          {record.medications && (
            <div className="rounded-lg border bg-card p-6">
              <h2 className="text-lg font-semibold mb-2">Current Medications</h2>
              <p className="text-sm">{record.medications}</p>
            </div>
          )}

          {/* Immunizations */}
          {record.immunizations && (
            <div className="rounded-lg border bg-card p-6">
              <h2 className="text-lg font-semibold mb-2">Immunization Records</h2>
              <p className="text-sm">{record.immunizations}</p>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
