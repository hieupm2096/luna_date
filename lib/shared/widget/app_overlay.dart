import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:luna_date/core/extension/build_context_ext.dart';
import 'package:luna_date/shared/widget/misc/misc.dart';

const _alertDuration = Duration(seconds: 5);
// const _notificationDuration = Duration(seconds: 15);

class AppOverlay {
  factory AppOverlay() => _overlay;

  AppOverlay._internal();

  static final _overlay = AppOverlay._internal();

  void showDialog({
    required Widget Function(VoidCallback cancelFunc) dialogBuilder,
    VoidCallback? onClose,
  }) {
    BotToast.showCustomLoading(
      useSafeArea: false,
      toastBuilder: (cancelFunc) {
        return GestureDetector(
          onTap: () {
            onClose?.call();
            cancelFunc();
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: const Color(0xff0e0614).withOpacity(0.6),
            child: dialogBuilder(cancelFunc),
          ),
        );
      },
    );
  }

  // Show notification
  // void showNotification({
  //   String? title,
  //   String? content,
  //   Widget? icon,
  //   String? action,
  //   VoidCallback? onAction,
  //   VoidCallback? onClose,
  // }) {
  //   BotToast.showCustomNotification(
  //     duration: _notificationDuration,
  //     backButtonBehavior: BackButtonBehavior.close,
  //     toastBuilder: (cancelFunc) {
  //       return _Notification(
  //         title: title ?? 'Thông báo',
  //         content: content,
  //         duration: _notificationDuration,
  //         icon: icon,
  //         hasAction: onAction != null,
  //         action: action,
  //         onAction: () {
  //           onAction?.call();
  //           cancelFunc();
  //         },
  //         onClose: () {
  //           onClose?.call();
  //           cancelFunc();
  //         },
  //       );
  //     },
  //   );
  // }

  /// Show notification
  void showError({
    required BuildContext context,
    String? title,
    String? content,
    String? action,
    Duration? duration,
    VoidCallback? onAction,
    VoidCallback? onClose,
  }) {
    BotToast.showCustomNotification(
      duration: duration ?? _alertDuration,
      backButtonBehavior: BackButtonBehavior.close,
      onClose: () => onClose?.call(),
      toastBuilder: (cancelFunc) {
        return _Alert(
          title: title ?? 'Oops!',
          content: content,
          duration: duration ?? _alertDuration,
          backgroundColor: context.colorScheme.errorContainer,
          hasAction: onAction != null,
          action: action,
          onAction: () {
            onAction?.call();
            cancelFunc();
          },
          onClose: () {
            onClose?.call();
            cancelFunc();
          },
        );
      },
    );
  }

  // void showLoading() {
  //   BotToast.closeAllLoading();
  //   BotToast.showCustomLoading(
  //     backgroundColor: Colors.black45,
  //     toastBuilder: (cancelFunc) {
  //       return Center(
  //         child: Container(
  //           padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(32),
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Assets.lottie.loading.lottie(
  //                 repeat: true,
  //                 height: 160,
  //                 width: 160,
  //                 fit: BoxFit.cover,
  //                 frameRate: FrameRate.max,
  //               ),
  //               Text(
  //                 'Đang tải...',
  //                 style: $style.texts.title24.copyWith(
  //                   color: $style.colors.buttonOnPrimary,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void showToast({
    required BuildContext context,
    required String content,
    VoidCallback? onClose,
  }) {
    BotToast.showText(
      text: content,
      textStyle: context.titleMedium!.copyWith(
        color: Colors.white,
      ),
      onClose: onClose,
    );
  }

  void hideLoading() {
    BotToast.closeAllLoading();
  }
}

class _Alert extends StatelessWidget {
  const _Alert({
    required this.title,
    required this.duration,
    this.content,
    this.backgroundColor,
    this.hasAction = true,
    this.action,
    this.onClose,
    this.onAction,
  });

  final String title;
  final String? content;
  final Duration duration;
  final Color? backgroundColor;
  final bool hasAction;
  final String? action;
  final VoidCallback? onAction;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          8,
          16 + MediaQuery.of(context).viewPadding.top,
          8,
          12,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 16, 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: 24,
                      color: context.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: context.labelLarge!.copyWith(
                              color: context.colorScheme.onErrorContainer,
                            ),
                          ),
                          if (content != null) const SizedBox(height: 6),
                          if (content != null)
                            Text(
                              content!,
                              style: context.bodySmall!.copyWith(
                                color: context.colorScheme.onErrorContainer,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (content == null) const Spacer(),
              const SizedBox(width: 8),
              CountDownProgressIndicator(
                duration: duration.inSeconds,
                backgroundColor: context.colorScheme.errorContainer,
                valueColor: context.colorScheme.error,
                timeTextStyle: context.titleSmall!
                    .copyWith(color: context.colorScheme.onErrorContainer),
                timeFormatter: (seconds) => '${seconds}s',
              ),
              const SizedBox(width: 16),
              GestureDetector(
                child: Icon(
                  Icons.close_rounded,
                  size: 20,
                  color: context.colorScheme.onErrorContainer,
                ),
                onTap: () {
                  onClose?.call();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class _Notification extends StatelessWidget {
//   const _Notification({
//     required this.title,
//     this.content,
//     this.icon,
//     required this.duration,
//     this.hasAction = true,
//     this.action,
//     this.onClose,
//     this.onAction,
//   });

//   final String title;
//   final String? content;
//   final Widget? icon;
//   final Duration duration;
//   final bool hasAction;
//   final String? action;
//   final VoidCallback? onAction;
//   final VoidCallback? onClose;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Padding(
//         padding: EdgeInsets.fromLTRB(
//           8,
//           16 + MediaQuery.of(context).viewPadding.top,
//           8,
//           12,
//         ),
//         child: Container(
//           padding: const EdgeInsets.fromLTRB(12, 12, 16, 16),
//           decoration: BoxDecoration(
//             color: $style.colors.background,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Expanded(
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (icon != null) icon!,
//                     if (icon != null) const SizedBox(width: 8),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             title,
//                             style: $style.texts.title14Bold,
//                           ),
//                           if (content != null) const SizedBox(height: 6),
//                           if (content != null)
//                             Text(
//                               content!,
//                               style: $style.texts.note12,
//                               maxLines: 3,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (content == null) const Spacer(),
//               const SizedBox(width: 8),
//               CountDownProgressIndicator(
//                 duration: duration.inSeconds,
//                 backgroundColor: $style.colors.background,
//                 valueColor: $style.colors.textSecondary,
//                 timeTextStyle: $style.texts.note12.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: $style.colors.textSecondary,
//                 ),
//                 timeFormatter: (seconds) => '${seconds}s',
//               ),
//               const SizedBox(width: 16),
//               GestureDetector(
//                 child: Assets.icons.icClear.svg(
//                   height: 20,
//                   width: 20,
//                 ),
//                 onTap: () {
//                   onClose?.call();
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
