import 'package:flutter/material.dart';

enum RouterType { goName, pushName, relacementName, pushReplacementNamed }

enum RequestStatus {
  init,
  loading,
  success,
  failed,
  resendSuccess,
  logoutSuccess,
}

enum RequestStatusType { pending, confirmed, reject }

enum OtpVerifyType { register, forgetPassword, updatemail, activeAccount }

enum VerifyType { forgetPassword, register, verifyEmailUpdate, verifyPhone }

enum LocalEnumKey { accessToken, refreshToken, userName, userEmail, userPhone }

enum ToastStates { success, warning, error, info }

/// How the running build compares to what Remote Config advertises.
enum AppUpdateStatus {
  /// At or above `latest_version` - nothing to show.
  upToDate,

  /// Below `latest_version` but at or above `minimum_version` - a
  /// dismissible prompt.
  optional,

  /// Below `minimum_version` - a blocking dialog, the app stops here.
  forced,
}

enum MembershipRequestStatus {
  pending,
  awaitingApplicationFee,
  approved,
  rejected,
  underReview,
  readyForInterview,
  needsClarification,
  unknown;

  static MembershipRequestStatus fromString(String status) {
    switch (status) {
      case 'pending':
        return MembershipRequestStatus.pending;
      case 'awaiting_application_fee':
        return MembershipRequestStatus.awaitingApplicationFee;
      case 'approved':
        return MembershipRequestStatus.approved;
      case 'rejected':
        return MembershipRequestStatus.rejected;
      case 'under_review':
        return MembershipRequestStatus.underReview;
      case 'ready_for_interview':
        return MembershipRequestStatus.readyForInterview;
      case 'needs_clarification':
        return MembershipRequestStatus.needsClarification;
      default:
        return MembershipRequestStatus.unknown;
    }
  }
}

extension MembershipRequestStatusExt on MembershipRequestStatus {
  String get label {
    switch (this) {
      case MembershipRequestStatus.pending:
        return 'قيد الانتظار';
      case MembershipRequestStatus.awaitingApplicationFee:
        return 'في انتظار سداد رسوم الطلب';
      case MembershipRequestStatus.approved:
        return 'موافق عليه';
      case MembershipRequestStatus.rejected:
        return 'مرفوض';
      case MembershipRequestStatus.underReview:
        return 'قيد المراجعة';
      case MembershipRequestStatus.readyForInterview:
        return 'جاهز للمقابلة';
      case MembershipRequestStatus.needsClarification:
        return 'بيانات تحتاج توضيح';
      case MembershipRequestStatus.unknown:
        return 'غير معروف';
    }
  }

  Color get color {
    switch (this) {
      case MembershipRequestStatus.pending:
        return Colors.orange;
      case MembershipRequestStatus.awaitingApplicationFee:
        return Colors.amber.shade700;
      case MembershipRequestStatus.approved:
        return Colors.green;
      case MembershipRequestStatus.rejected:
        return Colors.red;
      case MembershipRequestStatus.underReview:
        return Colors.blue;
      case MembershipRequestStatus.readyForInterview:
        return Colors.purple;
      case MembershipRequestStatus.needsClarification:
        return Colors.deepOrange;
      case MembershipRequestStatus.unknown:
        return Colors.grey;
    }
  }

  IconData get icon {
    switch (this) {
      case MembershipRequestStatus.pending:
        return Icons.access_time;
      case MembershipRequestStatus.awaitingApplicationFee:
        return Icons.payment;
      case MembershipRequestStatus.approved:
        return Icons.check_circle_outline;
      case MembershipRequestStatus.rejected:
        return Icons.cancel_outlined;
      case MembershipRequestStatus.underReview:
        return Icons.search;
      case MembershipRequestStatus.readyForInterview:
        return Icons.people_outline;
      case MembershipRequestStatus.needsClarification:
        return Icons.help_outline;
      case MembershipRequestStatus.unknown:
        return Icons.info_outline;
    }
  }
}

enum InvoiceKind {
  singleYear,
  cumulative,
  establishmentAid,
  applicationFee,
  unknown;

  static InvoiceKind fromString(String? kind) {
    switch (kind) {
      case 'single_year':
        return InvoiceKind.singleYear;
      case 'cumulative':
        return InvoiceKind.cumulative;
      case 'establishment_aid':
        return InvoiceKind.establishmentAid;
      case 'application_fee':
        return InvoiceKind.applicationFee;
      default:
        return InvoiceKind.unknown;
    }
  }
}

extension InvoiceKindExt on InvoiceKind {
  String get label {
    switch (this) {
      case InvoiceKind.singleYear:
        return 'سنة واحدة';
      case InvoiceKind.cumulative:
        return 'فاتوره تراكمية';
      case InvoiceKind.establishmentAid:
        return 'إعانة إنشائية';
      case InvoiceKind.applicationFee:
        return 'رسوم طلب العضوية';
      case InvoiceKind.unknown:
        return 'غير معروف';
    }
  }
}
