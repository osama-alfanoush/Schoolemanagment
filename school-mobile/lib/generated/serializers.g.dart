// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(AcademicYear.serializer)
          ..add(AccountingAuditTrail200Response.serializer)
          ..add(AccountingAuditTrail200ResponseData.serializer)
          ..add(AccountingBalanceSheet200Response.serializer)
          ..add(AccountingBalanceSheet200ResponseData.serializer)
          ..add(AccountingBalanceSheet200ResponseDataAssetsInner.serializer)
          ..add(AccountingIncomeStatement200Response.serializer)
          ..add(AccountingIncomeStatement200ResponseData.serializer)
          ..add(AccountingIndexAccounts200Response.serializer)
          ..add(AccountingIndexBudget200Response.serializer)
          ..add(AccountingIndexBudget200ResponseSummary.serializer)
          ..add(AccountingIndexClosings200Response.serializer)
          ..add(AccountingIndexJournalBatches200Response.serializer)
          ..add(AccountingIndexJournalBatches200ResponseLinksInner.serializer)
          ..add(AccountingIndexJournalEntries200Response.serializer)
          ..add(AccountingIndexJournalEntries200ResponseData.serializer)
          ..add(AccountingShowJournalEntry200Response.serializer)
          ..add(AccountingShowJournalEntry404Response.serializer)
          ..add(AccountingShowJournalEntry404ResponseMessageEnum.serializer)
          ..add(AccountingStoreAccount201Response.serializer)
          ..add(AccountingStoreAccountRequest.serializer)
          ..add(AccountingStoreAccountRequestAccountTypeEnum.serializer)
          ..add(AccountingStoreJournalEntry271201Response.serializer)
          ..add(AccountingStoreJournalEntry271422Response.serializer)
          ..add(AccountingSyncBudgetActuals200Response.serializer)
          ..add(AccountingSyncBudgetActuals200ResponseData.serializer)
          ..add(
            AccountingSyncBudgetActuals200ResponseDataUpdatedInner.serializer,
          )
          ..add(AccountingTrialBalance200Response.serializer)
          ..add(AccountingTrialBalance200ResponseDataInner.serializer)
          ..add(AccountingUpdateAccountRequest.serializer)
          ..add(AccountingUpdateAccountRequestAccountTypeEnum.serializer)
          ..add(AdminAnnounceRequest.serializer)
          ..add(AdminAssignSubjectTeacher200Response.serializer)
          ..add(AdminAssignSubjectTeacher200ResponseMessageEnum.serializer)
          ..add(AdminAttendanceDashboard200Response.serializer)
          ..add(AdminAuditLogs200Response.serializer)
          ..add(AdminBulkImportStudents200Response.serializer)
          ..add(AdminBulkImportStudents200ResponseErrorsInner.serializer)
          ..add(AdminBulkImportStudents200ResponseErrorsInnerAnyOf.serializer)
          ..add(AdminBulkImportStudents200ResponseErrorsInnerAnyOf1.serializer)
          ..add(
            AdminBulkImportStudents200ResponseErrorsInnerAnyOf1ErrorEnum
                .serializer,
          )
          ..add(
            AdminBulkImportStudents200ResponseErrorsInnerAnyOf1RowEnum
                .serializer,
          )
          ..add(AdminBulkImportStudents200ResponseErrorsInnerAnyOf2.serializer)
          ..add(
            AdminBulkImportStudents200ResponseErrorsInnerAnyOf2RowEnum
                .serializer,
          )
          ..add(
            AdminBulkImportStudents200ResponseErrorsInnerAnyOfErrorEnum
                .serializer,
          )
          ..add(
            AdminBulkImportStudents200ResponseErrorsInnerAnyOfRowEnum
                .serializer,
          )
          ..add(AdminDashboardKpis200Response.serializer)
          ..add(AdminDashboardKpis200ResponseData.serializer)
          ..add(AdminDashboardKpis200ResponseSummary.serializer)
          ..add(AdminGetAnnouncements200Response.serializer)
          ..add(AdminHrRequests200Response.serializer)
          ..add(AdminLinkParentStudent200Response.serializer)
          ..add(AdminLinkParentStudent200ResponseMessageEnum.serializer)
          ..add(AdminListPermissions200Response.serializer)
          ..add(AdminListUsers200Response.serializer)
          ..add(AdminListUsers200ResponseData.serializer)
          ..add(AdminMonthlyReport200Response.serializer)
          ..add(AdminMonthlyReport200ResponseFinance.serializer)
          ..add(AdminReviewHrRequest403Response.serializer)
          ..add(AdminReviewHrRequest403ResponseMessageEnum.serializer)
          ..add(AdminRolePermissions200Response.serializer)
          ..add(AdminUpdateRolePermissionsRequest.serializer)
          ..add(AdminUpdateUserPermissions200Response.serializer)
          ..add(AdminUpdateUserPermissionsRequest.serializer)
          ..add(AdminUserPermissions200Response.serializer)
          ..add(AdminUserPermissions200ResponseEffective.serializer)
          ..add(AdminUserPermissions200ResponseRoleKeys.serializer)
          ..add(Announcement.serializer)
          ..add(Assignment.serializer)
          ..add(AttendanceRecord.serializer)
          ..add(AuditLog.serializer)
          ..add(AuthChangePassword200Response.serializer)
          ..add(AuthChangePassword200ResponseAnyOf.serializer)
          ..add(AuthChangePassword200ResponseAnyOf1.serializer)
          ..add(AuthChangePassword200ResponseAnyOf1ExpiresInEnum.serializer)
          ..add(AuthChangePassword200ResponseAnyOf1MessageEnum.serializer)
          ..add(AuthChangePassword200ResponseAnyOf1TokenTypeEnum.serializer)
          ..add(AuthChangePassword200ResponseAnyOfExpiresInEnum.serializer)
          ..add(AuthChangePassword200ResponseAnyOfMessageEnum.serializer)
          ..add(AuthChangePassword200ResponseAnyOfTokenTypeEnum.serializer)
          ..add(AuthChangePasswordRequest.serializer)
          ..add(AuthCsrfCookie200Response.serializer)
          ..add(AuthForgotPassword200Response.serializer)
          ..add(AuthForgotPassword200ResponseMessageEnum.serializer)
          ..add(AuthForgotPasswordRequest.serializer)
          ..add(AuthLogin200Response.serializer)
          ..add(AuthLogin200ResponseAnyOf.serializer)
          ..add(AuthLogin200ResponseAnyOf1.serializer)
          ..add(AuthLogin200ResponseAnyOf1ExpiresInEnum.serializer)
          ..add(AuthLogin200ResponseAnyOf1TokenTypeEnum.serializer)
          ..add(AuthLogin200ResponseAnyOfExpiresInEnum.serializer)
          ..add(AuthLogin200ResponseAnyOfTokenTypeEnum.serializer)
          ..add(AuthLogin202Response.serializer)
          ..add(AuthLogin202ResponseTokenTypeEnum.serializer)
          ..add(AuthLoginRequest.serializer)
          ..add(AuthLogout200Response.serializer)
          ..add(AuthLogout200ResponseMessageEnum.serializer)
          ..add(AuthMe200Response.serializer)
          ..add(AuthMe200ResponsePermissions.serializer)
          ..add(AuthRefresh200Response.serializer)
          ..add(AuthRefresh200ResponseAnyOf.serializer)
          ..add(AuthRefresh200ResponseAnyOf1.serializer)
          ..add(AuthRefresh200ResponseAnyOf1ExpiresInEnum.serializer)
          ..add(AuthRefresh200ResponseAnyOf1TokenTypeEnum.serializer)
          ..add(AuthRefresh200ResponseAnyOfExpiresInEnum.serializer)
          ..add(AuthRefresh200ResponseAnyOfTokenTypeEnum.serializer)
          ..add(AuthRegisterPushToken200Response.serializer)
          ..add(AuthRegisterPushToken200ResponseMessageEnum.serializer)
          ..add(AuthRegisterPushTokenRequest.serializer)
          ..add(AuthRegisterPushTokenRequestPlatformEnum.serializer)
          ..add(AuthResetPasswordRequest.serializer)
          ..add(AuthUpdateProfile200Response.serializer)
          ..add(AuthUpdateProfileRequest.serializer)
          ..add(AuthUpdateProfileRequestLocaleEnum.serializer)
          ..add(AuthUploadProfilePhoto200Response.serializer)
          ..add(AuthUploadProfilePhoto200ResponseMessageEnum.serializer)
          ..add(BudgetPlan.serializer)
          ..add(CalendarEvent.serializer)
          ..add(ChartOfAccount.serializer)
          ..add(ClassRoom.serializer)
          ..add(ConductLog.serializer)
          ..add(DeltaChangeResource.serializer)
          ..add(DeltaPageResource.serializer)
          ..add(DisciplinaryWarning.serializer)
          ..add(EmployeeAdvance.serializer)
          ..add(EmployeeContract.serializer)
          ..add(EnrollmentStoreRequest.serializer)
          ..add(EnrollmentStoreRequestStatusEnum.serializer)
          ..add(EnrollmentTransferRequest.serializer)
          ..add(Exam.serializer)
          ..add(FeeStructure.serializer)
          ..add(FileProfilePhoto403Response.serializer)
          ..add(FinanceFeeStructures256Request.serializer)
          ..add(FinanceFeeStructures256RequestBillingCycleEnum.serializer)
          ..add(FinanceFinancialReports200Response.serializer)
          ..add(FinanceGenerateInvoices201Response.serializer)
          ..add(FinanceGenerateInvoicesRequest.serializer)
          ..add(FinanceInvoices200Response.serializer)
          ..add(FinanceInvoices200ResponseSummary.serializer)
          ..add(FinanceMarkPayrollPaid410Response.serializer)
          ..add(FinanceMarkPayrollPaid410ResponseCodeEnum.serializer)
          ..add(FinanceMarkPayrollPaid410ResponseMessageEnum.serializer)
          ..add(FinanceProcessPayroll410Response.serializer)
          ..add(FinanceProcessPayroll410ResponseCodeEnum.serializer)
          ..add(FinanceProcessPayroll410ResponseMessageEnum.serializer)
          ..add(FinanceRecordPaymentRequest.serializer)
          ..add(FinanceRecordPaymentRequestMethodEnum.serializer)
          ..add(FinanceSendReminders200Response.serializer)
          ..add(FinanceUpdateFeeStructureRequest.serializer)
          ..add(FinanceUpdateFeeStructureRequestBillingCycleEnum.serializer)
          ..add(FinancialClosing.serializer)
          ..add(FinancialWorkspaceIndexAdjustments200Response.serializer)
          ..add(FinancialWorkspaceIndexReceipts200Response.serializer)
          ..add(FinancialWorkspaceStudentProfile200Response.serializer)
          ..add(FinancialWorkspaceStudentProfile200ResponseSummary.serializer)
          ..add(FinancialWorkspaceStudentStatement200Response.serializer)
          ..add(GoodsReceipt.serializer)
          ..add(Grade.serializer)
          ..add(GradeComponent.serializer)
          ..add(Gradebook.serializer)
          ..add(GradebookIssue201Response.serializer)
          ..add(GradebookIssueRequest.serializer)
          ..add(GradebookReopenRequest.serializer)
          ..add(GradebookShow97200Response.serializer)
          ..add(GradebookSubmit200Response.serializer)
          ..add(HealthzGet200Response.serializer)
          ..add(HealthzGet200ResponseStatusEnum.serializer)
          ..add(HrApplications200Response.serializer)
          ..add(HrCreateEvaluationRequest.serializer)
          ..add(HrCreateEvaluationRequestCriteriaScoresInner.serializer)
          ..add(HrEvaluations200Response.serializer)
          ..add(HrJobs337200Response.serializer)
          ..add(HrJobs338Request.serializer)
          ..add(HrJobs338RequestPositionTypeEnum.serializer)
          ..add(HrPayrollAdvances200Response.serializer)
          ..add(HrPayrollContractHistory200Response.serializer)
          ..add(HrPayrollContractHistory200ResponseEmployment.serializer)
          ..add(HrPayrollContracts200Response.serializer)
          ..add(HrPayrollDashboard200Response.serializer)
          ..add(HrPayrollDisburseAdvanceRequest.serializer)
          ..add(HrPayrollRejectAdvanceRequest.serializer)
          ..add(HrPayrollReport200Response.serializer)
          ..add(HrPayrollReport200ResponseAnyOf.serializer)
          ..add(HrPayrollReport200ResponseAnyOf1.serializer)
          ..add(HrPayrollReport200ResponseAnyOf2.serializer)
          ..add(HrPayrollRescheduleAdvanceRequest.serializer)
          ..add(HrPayrollSetting.serializer)
          ..add(HrPayrollStoreAdvanceRequest.serializer)
          ..add(HrPayrollStoreContractRequest.serializer)
          ..add(HrPayrollStoreWarningRequest.serializer)
          ..add(HrPayrollTransitionWarningRequest.serializer)
          ..add(HrPayrollWarnings200Response.serializer)
          ..add(HrRequest.serializer)
          ..add(HrReviewRequest327Request.serializer)
          ..add(HrReviewRequest327RequestStatusEnum.serializer)
          ..add(HrStaffAttendance331200Response.serializer)
          ..add(HrStaffAttendance331200ResponseAnyOf.serializer)
          ..add(HrStaffAttendance331200ResponseAnyOfMessageEnum.serializer)
          ..add(HrStaffAttendance331RecordsParameterInner.serializer)
          ..add(HrStaffAttendance331RecordsParameterInnerStatusEnum.serializer)
          ..add(HrStaffAttendance332Request.serializer)
          ..add(HrSubmitRequest25403Response.serializer)
          ..add(HrSubmitRequest25403ResponseMessageEnum.serializer)
          ..add(HrSubmitRequest25Request.serializer)
          ..add(HrSubmitRequest25RequestTypeEnum.serializer)
          ..add(HrUpdateApplicationStatusRequest.serializer)
          ..add(HrUpdateApplicationStatusRequestStatusEnum.serializer)
          ..add(HrUpdateStaffRequest.serializer)
          ..add(HrUpdateStaffRequestEmploymentStatusEnum.serializer)
          ..add(InlineObject.serializer)
          ..add(Installment.serializer)
          ..add(InstallmentDue200Response.serializer)
          ..add(InstallmentIndexPlans200Response.serializer)
          ..add(InstallmentPayInstallmentRequest.serializer)
          ..add(InstallmentPayInstallmentRequestMethodEnum.serializer)
          ..add(InstallmentSendReminders200Response.serializer)
          ..add(InstallmentStorePlanRequest.serializer)
          ..add(InstallmentStorePlanRequestFrequencyEnum.serializer)
          ..add(InstallmentUpdatePlanRequest.serializer)
          ..add(InstallmentUpdatePlanRequestStatusEnum.serializer)
          ..add(InventoryCount.serializer)
          ..add(Invoice.serializer)
          ..add(JobApplication.serializer)
          ..add(JobPosting.serializer)
          ..add(JournalBatch.serializer)
          ..add(JournalEntry.serializer)
          ..add(LengthAwarePaginator.serializer)
          ..add(LibraryAllBorrowings200Response.serializer)
          ..add(LibraryAvailableBooks200Response.serializer)
          ..add(LibraryBook.serializer)
          ..add(LibraryBooks168Request.serializer)
          ..add(LibraryBorrowing.serializer)
          ..add(LibraryMyBorrowings200Response.serializer)
          ..add(LibrarySelfReturn200Response.serializer)
          ..add(LibrarySelfReturn200ResponseMessageEnum.serializer)
          ..add(LibraryUpdateBookRequest.serializer)
          ..add(MessagingConversation403Response.serializer)
          ..add(MessagingConversation403ResponseMessageEnum.serializer)
          ..add(MessagingSendRequest.serializer)
          ..add(MessagingThreads200ResponseInner.serializer)
          ..add(MessagingThreads200ResponseInnerLastMessage.serializer)
          ..add(MessagingThreads200ResponseInnerOtherUser.serializer)
          ..add(MfaChallengeRequest.serializer)
          ..add(MfaConfirmRequest.serializer)
          ..add(MfaDisable200Response.serializer)
          ..add(MfaDisable200ResponseMessageEnum.serializer)
          ..add(MfaEnroll200Response.serializer)
          ..add(MfaRegenerateRecoveryCodes200Response.serializer)
          ..add(MfaRegenerateRecoveryCodesRequest.serializer)
          ..add(MfaRequestHelpDeskRecovery201Response.serializer)
          ..add(Notification.serializer)
          ..add(NotificationAnalytics200Response.serializer)
          ..add(NotificationCleanup200Response.serializer)
          ..add(NotificationCleanup200ResponseMessageEnum.serializer)
          ..add(NotificationIndex200Response.serializer)
          ..add(NotificationMarkAllAsRead200Response.serializer)
          ..add(NotificationMarkAllAsRead200ResponseMessageEnum.serializer)
          ..add(NotificationMarkAsClicked200Response.serializer)
          ..add(NotificationMarkAsClicked200ResponseMessageEnum.serializer)
          ..add(NotificationMarkAsRead200Response.serializer)
          ..add(NotificationMarkAsRead200ResponseMessageEnum.serializer)
          ..add(NotificationMarkAsRead404Response.serializer)
          ..add(NotificationMarkAsRead404ResponseMessageEnum.serializer)
          ..add(NotificationPreference.serializer)
          ..add(NotificationRegisterDevice200Response.serializer)
          ..add(NotificationRegisterDevice200ResponseMessageEnum.serializer)
          ..add(NotificationSeedTemplates200Response.serializer)
          ..add(NotificationSeedTemplates200ResponseMessageEnum.serializer)
          ..add(NotificationSendBulk200Response.serializer)
          ..add(NotificationSendBulk200ResponseMessageEnum.serializer)
          ..add(NotificationSendBulk400Response.serializer)
          ..add(NotificationSendBulk400ResponseMessageEnum.serializer)
          ..add(NotificationSendBulkRequest.serializer)
          ..add(NotificationSendBulkRequestTarget.serializer)
          ..add(NotificationSendTest200Response.serializer)
          ..add(NotificationSendTest200ResponseMessageEnum.serializer)
          ..add(NotificationSendTest400Response.serializer)
          ..add(NotificationSendTest400ResponseMessageEnum.serializer)
          ..add(NotificationSendTestRequest.serializer)
          ..add(NotificationTemplate.serializer)
          ..add(NotificationUnreadCount200Response.serializer)
          ..add(NotificationUnregisterDevice200Response.serializer)
          ..add(NotificationUnregisterDevice200ResponseMessageEnum.serializer)
          ..add(NotificationUnregisterDevice404Response.serializer)
          ..add(NotificationUnregisterDevice404ResponseMessageEnum.serializer)
          ..add(NotificationUnregisterDeviceRequest.serializer)
          ..add(NotificationUpdatePreferencesRequest.serializer)
          ..add(NotificationUpdatePreferencesRequestQuietHours.serializer)
          ..add(NotificationUpdateTemplateRequest.serializer)
          ..add(NotificationUpdateTemplateRequestDefaultPriorityEnum.serializer)
          ..add(ParentChildAssignments200Response.serializer)
          ..add(ParentChildAssignments200ResponseMeta.serializer)
          ..add(ParentChildAttendance200Response.serializer)
          ..add(ParentChildAttendance200ResponseRecords.serializer)
          ..add(ParentChildGrades200Response.serializer)
          ..add(ParentChildInvoices200Response.serializer)
          ..add(ParentChildPerformanceChart200Response.serializer)
          ..add(ParentChildPerformanceChart200ResponseAnyOf.serializer)
          ..add(ParentChildPerformanceChart200ResponseAnyOf1.serializer)
          ..add(
            ParentChildPerformanceChart200ResponseAnyOfDatasetsInner.serializer,
          )
          ..add(ParentChildReportCard200Response.serializer)
          ..add(ParentChildReportCard200ResponseGrades.serializer)
          ..add(ParentFinanceInstallments200Response.serializer)
          ..add(ParentFinanceInstallments200ResponseData.serializer)
          ..add(ParentFinanceInstallments403Response.serializer)
          ..add(ParentFinanceInstallments403ResponseMessageEnum.serializer)
          ..add(ParentFinanceInvoice200Response.serializer)
          ..add(ParentFinanceInvoices200Response.serializer)
          ..add(ParentFinanceInvoices200ResponseData.serializer)
          ..add(ParentFinancePayIntent409Response.serializer)
          ..add(ParentFinancePayIntentRequest.serializer)
          ..add(ParentFinanceSummary200Response.serializer)
          ..add(ParentFinanceSummary200ResponseData.serializer)
          ..add(ParentFinanceSummary200ResponseDataAnyOf.serializer)
          ..add(ParentFinanceSummary200ResponseDataAnyOf1.serializer)
          ..add(
            ParentFinanceSummary200ResponseDataAnyOfChildrenInner.serializer,
          )
          ..add(
            ParentFinanceSummary200ResponseDataAnyOfChildrenInnerBilled
                .serializer,
          )
          ..add(
            ParentFinanceSummary200ResponseDataAnyOfChildrenInnerOutstanding
                .serializer,
          )
          ..add(
            ParentFinanceSummary200ResponseDataAnyOfChildrenInnerPaid
                .serializer,
          )
          ..add(ParentFinanceSummary200ResponseDataAnyOfTotal.serializer)
          ..add(ParentHomeBootstrap200Response.serializer)
          ..add(ParentHomeBootstrap200ResponseData.serializer)
          ..add(ParentHomeBootstrap200ResponseDataTheme.serializer)
          ..add(ParentHomeBootstrap200ResponseDataUser.serializer)
          ..add(ParentHomeChildOverview200Response.serializer)
          ..add(ParentHomeChildOverview403Response.serializer)
          ..add(ParentHomeChildOverview403ResponseMessageEnum.serializer)
          ..add(ParentHomeChildOverview404Response.serializer)
          ..add(ParentHomeChildOverview404ResponseMessageEnum.serializer)
          ..add(ParentHomeHome200Response.serializer)
          ..add(ParentHomeHome200ResponseData.serializer)
          ..add(ParentHomeHome200ResponseDataAnyOf.serializer)
          ..add(ParentHomeHome200ResponseDataAnyOf1.serializer)
          ..add(ParentInviteActivate200Response.serializer)
          ..add(ParentInviteActivate200ResponseTokenTypeEnum.serializer)
          ..add(ParentInviteActivate200ResponseUser.serializer)
          ..add(ParentInviteActivate403Response.serializer)
          ..add(ParentInviteActivate403ResponseMessageEnum.serializer)
          ..add(ParentInviteActivateRequest.serializer)
          ..add(ParentInviteStore201Response.serializer)
          ..add(ParentInviteStore201ResponseData.serializer)
          ..add(ParentInviteStore404Response.serializer)
          ..add(ParentInviteStore404ResponseMessageEnum.serializer)
          ..add(ParentInviteStoreRequest.serializer)
          ..add(ParentPaymentHistory200Response.serializer)
          ..add(PasswordReset200Response.serializer)
          ..add(PasswordReset200ResponseMessageEnum.serializer)
          ..add(Payment.serializer)
          ..add(PaymentConfirmPayment200Response.serializer)
          ..add(PaymentConfirmPayment200ResponseMessageEnum.serializer)
          ..add(PaymentConfirmPayment400Response.serializer)
          ..add(PaymentConfirmPaymentRequest.serializer)
          ..add(PaymentCreatePaymentIntent200Response.serializer)
          ..add(PaymentCreatePaymentIntent403Response.serializer)
          ..add(PaymentCreatePaymentIntent403ResponseMessageEnum.serializer)
          ..add(PaymentCreatePaymentIntentRequest.serializer)
          ..add(PaymentCreateSetupIntent501Response.serializer)
          ..add(PaymentCreateSetupIntent501ResponseMessageEnum.serializer)
          ..add(PaymentGetPaymentMethods200Response.serializer)
          ..add(PaymentGetPaymentMethods200ResponseMessageEnum.serializer)
          ..add(PaymentGetStatus200Response.serializer)
          ..add(PaymentHandleWebhook200Response.serializer)
          ..add(PaymentHandleWebhook400Response.serializer)
          ..add(PaymentHandleWebhook400ResponseAnyOf.serializer)
          ..add(PaymentHandleWebhook400ResponseAnyOfMessageEnum.serializer)
          ..add(PaymentPlan.serializer)
          ..add(PaymentReceipt.serializer)
          ..add(PayrollAccountSetting.serializer)
          ..add(PayrollComponent.serializer)
          ..add(PayrollRecord.serializer)
          ..add(PayrollRun.serializer)
          ..add(PayrollSettingsAssignComponentRequest.serializer)
          ..add(PayrollSettingsIndex200Response.serializer)
          ..add(PayrollSettingsUpdateGeneralRequest.serializer)
          ..add(
            PayrollSettingsUpdateGeneralRequestNegativeNetPolicyEnum.serializer,
          )
          ..add(
            PayrollSettingsUpdateGeneralRequestProrationPolicyEnum.serializer,
          )
          ..add(PayrollStoreRunRequest.serializer)
          ..add(PayrollUpdateRecordRequest.serializer)
          ..add(PerformanceEvaluation.serializer)
          ..add(ProcurementApprovePurchaseOrderRequest.serializer)
          ..add(ProcurementApprovePurchaseOrderRequestActionEnum.serializer)
          ..add(ProcurementDashboard200Response.serializer)
          ..add(ProcurementDestroySupplier200Response.serializer)
          ..add(ProcurementDestroySupplier200ResponseMessageEnum.serializer)
          ..add(ProcurementDestroySupplier409Response.serializer)
          ..add(ProcurementDestroySupplier409ResponseMessageEnum.serializer)
          ..add(ProcurementFinanceApAging200Response.serializer)
          ..add(ProcurementFinanceApAging200ResponseDataInner.serializer)
          ..add(ProcurementFinanceCancelInvoice422Response.serializer)
          ..add(
            ProcurementFinanceCancelInvoice422ResponseMessageEnum.serializer,
          )
          ..add(ProcurementFinanceIndexInvoices200Response.serializer)
          ..add(ProcurementFinanceRecordPaymentRequest.serializer)
          ..add(ProcurementFinanceRecordPaymentRequestMethodEnum.serializer)
          ..add(ProcurementFinanceStoreInvoiceRequest.serializer)
          ..add(ProcurementFinanceUpdateInvoiceRequest.serializer)
          ..add(ProcurementIndexGoodsReceipts200Response.serializer)
          ..add(ProcurementIndexPurchaseOrders200Response.serializer)
          ..add(ProcurementIndexSuppliers200Response.serializer)
          ..add(ProcurementReceivePurchaseOrderRequest.serializer)
          ..add(ProcurementReceivePurchaseOrderRequestLinesInner.serializer)
          ..add(ProcurementStorePurchaseOrderRequest.serializer)
          ..add(ProcurementStorePurchaseOrderRequestItemsInner.serializer)
          ..add(ProcurementStoreSupplierRequest.serializer)
          ..add(ProcurementStoreSupplierRequestPaymentTermsEnum.serializer)
          ..add(ProcurementSupplierTransactions200Response.serializer)
          ..add(ProcurementUpdatePurchaseOrderRequest.serializer)
          ..add(ProcurementUpdatePurchaseOrderRequestItemsInner.serializer)
          ..add(ProcurementUpdateSupplierRequest.serializer)
          ..add(ProcurementUpdateSupplierRequestPaymentTermsEnum.serializer)
          ..add(PurchaseOrder.serializer)
          ..add(PurchaseRequest.serializer)
          ..add(ReportCardIssue.serializer)
          ..add(SchoolSetting.serializer)
          ..add(SocialInsuranceScheme.serializer)
          ..add(StaffAttendance.serializer)
          ..add(StaffPayrollComponent.serializer)
          ..add(StaffProfile.serializer)
          ..add(StockMovement.serializer)
          ..add(StudentAssignments200Response.serializer)
          ..add(StudentCalendar200Response.serializer)
          ..add(StudentDashboard200Response.serializer)
          ..add(StudentDashboard200ResponseUpcomingAssignments.serializer)
          ..add(StudentEnrollment.serializer)
          ..add(StudentFinancialAdjustment.serializer)
          ..add(StudentGrades200Response.serializer)
          ..add(StudentReportCard200Response.serializer)
          ..add(StudentSubmitAssignment403Response.serializer)
          ..add(StudentSubmitAssignment403ResponseMessageEnum.serializer)
          ..add(Subject.serializer)
          ..add(Submission.serializer)
          ..add(Supplier.serializer)
          ..add(SupplierInvoice.serializer)
          ..add(SupplierPayment.serializer)
          ..add(SupplierTransaction.serializer)
          ..add(SyncDelta200Response.serializer)
          ..add(SyncDelta403Response.serializer)
          ..add(SyncDelta403ResponseMessageEnum.serializer)
          ..add(TeacherAnnounceRequest.serializer)
          ..add(TeacherAssignmentSubmissions200Response.serializer)
          ..add(TeacherEnterGradeRequest.serializer)
          ..add(TeacherGradeComponents93Request.serializer)
          ..add(TeacherGradeComponents93RequestTypeEnum.serializer)
          ..add(TeacherGradeSubmissionRequest.serializer)
          ..add(TeacherLogConduct403Response.serializer)
          ..add(TeacherLogConduct403ResponseMessageEnum.serializer)
          ..add(TeacherLogConductRequest.serializer)
          ..add(TeacherLogConductRequestCategoryEnum.serializer)
          ..add(TeacherMarkAttendance200Response.serializer)
          ..add(TeacherMarkAttendance200ResponseMessageEnum.serializer)
          ..add(TeacherMarkAttendanceRequest.serializer)
          ..add(TeacherMarkAttendanceRequestRecordsInner.serializer)
          ..add(TeacherMarkAttendanceRequestRecordsInnerStatusEnum.serializer)
          ..add(TeacherMyClasses200Response.serializer)
          ..add(TeacherMyTimetable200Response.serializer)
          ..add(TimetableEntry.serializer)
          ..add(TransportAllAssignments200Response.serializer)
          ..add(TransportAssignment.serializer)
          ..add(TransportRoute.serializer)
          ..add(TransportRoutes173Request.serializer)
          ..add(TransportStop.serializer)
          ..add(TransportStops177Request.serializer)
          ..add(TransportVehicle.serializer)
          ..add(TransportVehicles175Request.serializer)
          ..add(User.serializer)
          ..add(UserDevice.serializer)
          ..add(WarehouseCategory.serializer)
          ..add(WarehouseConsumptionReport200Response.serializer)
          ..add(WarehouseConsumptionReport200ResponseDataInner.serializer)
          ..add(WarehouseDashboard200Response.serializer)
          ..add(WarehouseDashboard200ResponseMovementsThisMonth.serializer)
          ..add(WarehouseDashboard200ResponseTopConsumedItemsInner.serializer)
          ..add(WarehouseIndexCategories200Response.serializer)
          ..add(WarehouseIndexCounts200Response.serializer)
          ..add(WarehouseIndexItems195200Response.serializer)
          ..add(WarehouseIndexMovements200Response.serializer)
          ..add(WarehouseIndexPurchaseRequests200Response.serializer)
          ..add(WarehouseInventoryReport200Response.serializer)
          ..add(WarehouseInventoryReport200ResponseDataInner.serializer)
          ..add(WarehouseItem.serializer)
          ..add(WarehouseReviewPurchaseRequestRequest.serializer)
          ..add(WarehouseReviewPurchaseRequestRequestStatusEnum.serializer)
          ..add(WarehouseStoreCategory201Response.serializer)
          ..add(WarehouseStoreCategoryRequest.serializer)
          ..add(WarehouseStoreCounts201Response.serializer)
          ..add(WarehouseStoreCountsRequest.serializer)
          ..add(WarehouseStoreCountsRequestCountTypeEnum.serializer)
          ..add(WarehouseStoreCountsRequestItemsInner.serializer)
          ..add(WarehouseStoreItem201Response.serializer)
          ..add(WarehouseStoreItemRequest.serializer)
          ..add(WarehouseStoreMovement201Response.serializer)
          ..add(WarehouseStoreMovementRequest.serializer)
          ..add(WarehouseStoreMovementRequestMovementTypeEnum.serializer)
          ..add(WarehouseStorePurchaseRequest201Response.serializer)
          ..add(WarehouseStorePurchaseRequestRequest.serializer)
          ..add(WarehouseUpdateItemRequest.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(AccountingBalanceSheet200ResponseDataAssetsInner),
            ]),
            () =>
                ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(AccountingBalanceSheet200ResponseDataAssetsInner),
            ]),
            () =>
                ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(AccountingBalanceSheet200ResponseDataAssetsInner),
            ]),
            () =>
                ListBuilder<AccountingBalanceSheet200ResponseDataAssetsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingSyncBudgetActuals200ResponseDataUpdatedInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingSyncBudgetActuals200ResponseDataUpdatedInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(AccountingTrialBalance200ResponseDataInner),
            ]),
            () => ListBuilder<AccountingTrialBalance200ResponseDataInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(AdminBulkImportStudents200ResponseErrorsInner),
            ]),
            () => ListBuilder<AdminBulkImportStudents200ResponseErrorsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Announcement)]),
            () => ListBuilder<Announcement>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Assignment)]),
            () => ListBuilder<Assignment>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AttendanceRecord)]),
            () => ListBuilder<AttendanceRecord>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AuditLog)]),
            () => ListBuilder<AuditLog>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AuditLog)]),
            () => ListBuilder<AuditLog>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(BudgetPlan)]),
            () => ListBuilder<BudgetPlan>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(BuiltList, const [const FullType(String)]),
            ]),
            () => ListBuilder<BuiltList<String>>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(CalendarEvent)]),
            () => ListBuilder<CalendarEvent>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ChartOfAccount)]),
            () => ListBuilder<ChartOfAccount>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(ClassRoom)]),
            () => ListBuilder<ClassRoom>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(DeltaChangeResource),
            ]),
            () => ListBuilder<DeltaChangeResource>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(DisciplinaryWarning),
            ]),
            () => ListBuilder<DisciplinaryWarning>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(EmployeeAdvance)]),
            () => ListBuilder<EmployeeAdvance>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(EmployeeContract)]),
            () => ListBuilder<EmployeeContract>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(EmployeeContract)]),
            () => ListBuilder<EmployeeContract>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(EmployeeContract)]),
            () => ListBuilder<EmployeeContract>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(FinancialClosing)]),
            () => ListBuilder<FinancialClosing>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(GoodsReceipt)]),
            () => ListBuilder<GoodsReceipt>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Grade)]),
            () => ListBuilder<Grade>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Grade)]),
            () => ListBuilder<Grade>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Grade)]),
            () => ListBuilder<Grade>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(HrCreateEvaluationRequestCriteriaScoresInner),
            ]),
            () => ListBuilder<HrCreateEvaluationRequestCriteriaScoresInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(HrRequest)]),
            () => ListBuilder<HrRequest>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(HrStaffAttendance331RecordsParameterInner),
            ]),
            () => ListBuilder<HrStaffAttendance331RecordsParameterInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Installment)]),
            () => ListBuilder<Installment>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(InventoryCount)]),
            () => ListBuilder<InventoryCount>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(InventoryCount)]),
            () => ListBuilder<InventoryCount>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Invoice)]),
            () => ListBuilder<Invoice>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Invoice)]),
            () => ListBuilder<Invoice>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Invoice)]),
            () => ListBuilder<Invoice>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(PaymentPlan)]),
            () => ListBuilder<PaymentPlan>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Payment)]),
            () => ListBuilder<Payment>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(StudentFinancialAdjustment),
            ]),
            () => ListBuilder<StudentFinancialAdjustment>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(JobApplication)]),
            () => ListBuilder<JobApplication>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(JobPosting)]),
            () => ListBuilder<JobPosting>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(JournalBatch)]),
            () => ListBuilder<JournalBatch>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(JournalEntry)]),
            () => ListBuilder<JournalEntry>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LibraryBook)]),
            () => ListBuilder<LibraryBook>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LibraryBorrowing)]),
            () => ListBuilder<LibraryBorrowing>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(LibraryBorrowing)]),
            () => ListBuilder<LibraryBorrowing>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Notification)]),
            () => ListBuilder<Notification>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                ParentFinanceSummary200ResponseDataAnyOfChildrenInner,
              ),
            ]),
            () =>
                ListBuilder<
                  ParentFinanceSummary200ResponseDataAnyOfChildrenInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Payment)]),
            () => ListBuilder<Payment>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(PaymentPlan)]),
            () => ListBuilder<PaymentPlan>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(PaymentReceipt)]),
            () => ListBuilder<PaymentReceipt>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(PayrollComponent)]),
            () => ListBuilder<PayrollComponent>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SocialInsuranceScheme),
            ]),
            () => ListBuilder<SocialInsuranceScheme>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(PayrollRecord)]),
            () => ListBuilder<PayrollRecord>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(PayrollRun)]),
            () => ListBuilder<PayrollRun>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(PerformanceEvaluation),
            ]),
            () => ListBuilder<PerformanceEvaluation>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ProcurementFinanceApAging200ResponseDataInner),
            ]),
            () => ListBuilder<ProcurementFinanceApAging200ResponseDataInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ProcurementReceivePurchaseOrderRequestLinesInner),
            ]),
            () =>
                ListBuilder<ProcurementReceivePurchaseOrderRequestLinesInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ProcurementStorePurchaseOrderRequestItemsInner),
            ]),
            () => ListBuilder<ProcurementStorePurchaseOrderRequestItemsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(ProcurementUpdatePurchaseOrderRequestItemsInner),
            ]),
            () =>
                ListBuilder<ProcurementUpdatePurchaseOrderRequestItemsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(PurchaseOrder)]),
            () => ListBuilder<PurchaseOrder>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(PurchaseRequest)]),
            () => ListBuilder<PurchaseRequest>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(StaffProfile)]),
            () => ListBuilder<StaffProfile>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(StockMovement)]),
            () => ListBuilder<StockMovement>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                ParentChildPerformanceChart200ResponseAnyOfDatasetsInner,
              ),
            ]),
            () =>
                ListBuilder<
                  ParentChildPerformanceChart200ResponseAnyOfDatasetsInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(StudentFinancialAdjustment),
            ]),
            () => ListBuilder<StudentFinancialAdjustment>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Supplier)]),
            () => ListBuilder<Supplier>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(SupplierInvoice)]),
            () => ListBuilder<SupplierInvoice>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(SupplierTransaction),
            ]),
            () => ListBuilder<SupplierTransaction>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(TeacherMarkAttendanceRequestRecordsInner),
            ]),
            () => ListBuilder<TeacherMarkAttendanceRequestRecordsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(TimetableEntry)]),
            () => ListBuilder<TimetableEntry>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(TransportAssignment),
            ]),
            () => ListBuilder<TransportAssignment>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(User)]),
            () => ListBuilder<User>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(User)]),
            () => ListBuilder<User>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(WarehouseCategory),
            ]),
            () => ListBuilder<WarehouseCategory>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(WarehouseConsumptionReport200ResponseDataInner),
            ]),
            () => ListBuilder<WarehouseConsumptionReport200ResponseDataInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(WarehouseInventoryReport200ResponseDataInner),
            ]),
            () => ListBuilder<WarehouseInventoryReport200ResponseDataInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(WarehouseItem)]),
            () => ListBuilder<WarehouseItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                AccountingIndexJournalBatches200ResponseLinksInner,
              ),
            ]),
            () =>
                ListBuilder<
                  AccountingIndexJournalBatches200ResponseLinksInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(WarehouseItem)]),
            () => ListBuilder<WarehouseItem>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                WarehouseDashboard200ResponseTopConsumedItemsInner,
              ),
            ]),
            () =>
                ListBuilder<
                  WarehouseDashboard200ResponseTopConsumedItemsInner
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(WarehouseStoreCountsRequestItemsInner),
            ]),
            () => ListBuilder<WarehouseStoreCountsRequestItemsInner>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(int)]),
            () => ListBuilder<int>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(AttendanceRecord)]),
            () => ListBuilder<AttendanceRecord>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(BuiltMap, const [
                const FullType(String),
                const FullType.nullable(JsonObject),
              ]),
            ]),
            () => ListBuilder<BuiltMap<String, JsonObject?>>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(Payment)]),
            () => ListBuilder<Payment>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType.nullable(JsonObject),
            ]),
            () => ListBuilder<JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType.nullable(num)]),
            () => ListBuilder<num?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltList, const [const FullType(String)]),
            ]),
            () => MapBuilder<String, BuiltList<String>>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(String),
            ]),
            () => MapBuilder<String, String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType.nullable(JsonObject),
            ]),
            () => MapBuilder<String, JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType.nullable(JsonObject),
            ]),
            () => MapBuilder<String, JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType.nullable(JsonObject),
            ]),
            () => MapBuilder<String, JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType.nullable(JsonObject),
            ]),
            () => MapBuilder<String, JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType.nullable(JsonObject),
            ]),
            () => MapBuilder<String, JsonObject?>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltMap, const [
              const FullType(String),
              const FullType.nullable(JsonObject),
            ]),
            () => MapBuilder<String, JsonObject?>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
