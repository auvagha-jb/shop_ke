import 'package:shop_ke/core/models/ui_response.dart';

const generalExceptionResponse = const UIResponse(
  title: 'Unexpected error',
  message:
      'Something went wrong on our end. Please try again later. Apologies for the inconvenience',
);

const generalAuthExceptionResponse = const UIResponse(
  title: 'Authentication failure',
  message: 'Something went wrong. Please check your connection and try again',
);

const networkExceptionResponse = const UIResponse(
  title: 'Connection lost',
  message: 'Please check your connection and try again',
);

const nullUserExceptionResponse = const UIResponse(
  title: 'No user found',
  message: 'No account matches the given credentials.',
);

const codeExceptionResponse = const UIResponse(
  title: 'Invalid Code',
  message: 'Please enter the correct code and try again',
);

const cameraExceptionResponse = const UIResponse(
  title: 'Camera error',
  message: 'Failed to retrieve camera preview',
);

const cameraNotReadyResponse = const UIResponse(
  title: 'Camera not ready',
  message: 'Camera is setting up. Please wait',
);

UIResponse nullValueException(String nullValue) {
  return UIResponse(
    title: 'Null value',
    message: '$nullValue not found',
  );
}
