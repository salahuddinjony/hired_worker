// import 'package:flutter/foundation.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// import '../helper/shared_prefe/shared_prefe.dart';
// import '../utils/app_const/app_const.dart';
// import 'api_url.dart';

// class SocketApi {
//   // Singleton setup
//   SocketApi._internal();
//   static final SocketApi _instance = SocketApi._internal();
//   factory SocketApi() => _instance;

//   static io.Socket? _socket;

//   ///<------------------------- Initialize Socket ------------------------->
//   static Future<void> init() async {
//     final userId = await SharePrefsHelper.getString(AppConstants.userId);

//     if (userId.isEmpty || userId == "null") {
//       debugPrint('❌ Socket initialization failed: Invalid userId');
//       return;
//     }

//     if (_socket != null) {
//       debugPrint('🔄 Disconnecting existing socket...');
//       _socket!.disconnect();
//       _socket!.dispose();
//       _socket = null;
//     }

//     debugPrint('🌐 Connecting socket with userId: $userId');

//     _socket = io.io(
//       ApiUrl.socketUrl,  
//       io.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableAutoConnect()
//           .setQuery({'userId': userId})  
//           .setReconnectionAttempts(10)
//           .setReconnectionDelay(3000)
//           .build(),
//     );

//     _socket!.onConnect((_) {
//       debugPrint('✅ Socket Connected: ${_socket!.id}');
//     });

//     _socket!.onDisconnect((reason) {
//       debugPrint('❌ Socket Disconnected: $reason');
//     });

//     _socket!.onError((error) {
//       debugPrint('⚠️ Socket Error: $error');
//     });

//     _socket!.on('unauthorized', (data) {
//       debugPrint('🚫 Unauthorized Access: $data');
//     });

//     _socket!.onAny((event, data) {
//       debugPrint('📥 [Received Event] $event: $data');
//     });

//     // Optional: emit joinRoom or similar, only if your backend expects it
//     // _socket!.emit('joinRoom', {'userId': userId});
//   }

//   ///<------------------------- Socket Connection Status ------------------------->
//   static bool isConnected() {
//     final connected = _socket?.connected ?? false;
//     debugPrint('🔍 isConnected: $connected');
//     return connected;
//   }

//   ///<------------------------- Emit Event ------------------------->
//   static void sendEvent(String eventName, dynamic data) {
//     if (isConnected()) {
//       debugPrint('📤 Emitting: $eventName -> $data');
//       _socket!.emit(eventName, data);
//     } else {
//       debugPrint('❌ Failed to emit: $eventName. Socket not connected.');
//     }
//   }

//   ///<------------------------- Listen to Event ------------------------->
//   static void listen(String eventName, Function(dynamic) callback) {
//     if (!isConnected()) {
//       debugPrint('⚠️ Cannot listen to $eventName. Socket not connected.');
//       return;
//     }

//     _socket!.off(eventName); // Prevent duplicate listeners
//     _socket!.on(eventName, (data) {
//       debugPrint('🔔 [$eventName] -> $data');
//       callback(data);
//     });
//   }

//   ///<------------------------- Disconnect ------------------------->
//   static void dispose() {
//     debugPrint('🛑 Disconnecting socket...');
//     _socket?.disconnect();
//     _socket?.dispose();
//     _socket = null;
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../helper/shared_prefe/shared_prefe.dart';
import '../utils/app_const/app_const.dart';
import 'api_url.dart';

class SocketApi {
  // Singleton setup
  SocketApi._internal();
  static final SocketApi _instance = SocketApi._internal();
  factory SocketApi() => _instance;

  static io.Socket? _socket;

  ///<------------------------- Initialize Socket ------------------------->  
  static Future<void> init() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);

    if (userId.isEmpty || userId == "null") {
      debugPrint('❌ Socket initialization failed: Invalid userId');
      return;
    }

    // Dispose old socket if already connected
    if (_socket != null) {
      debugPrint('🔄 Disconnecting existing socket...');
      _socket?.disconnect();
      _socket?.dispose();
      _socket = null;
    }

    debugPrint('🌐 Connecting socket with userId: $userId');

    _socket = io.io(
      ApiUrl.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // Manual connect for better control
          .setQuery({'userId': userId}) // Backend expects query string
          .setReconnectionAttempts(10)
          .setReconnectionDelay(3000)
          .setTimeout(5000) // Optional: connection timeout
          .build(),
    );

    // Connection success
    _socket?.onConnect((_) {
      debugPrint('✅ Socket Connected: ${_socket?.id}');
    });

    // Connection closed
    _socket?.onDisconnect((reason) {
      debugPrint('❌ Socket Disconnected: $reason');
    });

    // Reconnection events
    _socket?.onReconnect((_) {
      debugPrint('🔁 Reconnected successfully');
    });

    _socket?.onReconnectAttempt((_) {
      debugPrint('🔄 Attempting to reconnect...');
    });

    // Error
    _socket?.onError((error) {
      debugPrint('⚠️ Socket Error: $error');
    });

    // Unauthorized (custom server-side event)
    _socket?.on('unauthorized', (data) {
      debugPrint('🚫 Unauthorized Access: $data');
    });

    // Catch-all listener
    _socket?.onAny((event, data) {
      debugPrint('📥 [Received Event] $event: $data');
    });

    // Manually connect after setting everything up
    _socket?.connect();
  }

  ///<------------------------- Socket Connection Status ------------------------->  
  static bool isConnected() {
    final connected = _socket?.connected ?? false;
    debugPrint('🔍 isConnected: $connected');
    return connected;
  }

  ///<------------------------- Emit Event ------------------------->  
  static void sendEvent(String eventName, dynamic data) {
    if (isConnected()) {
      debugPrint('📤 Emitting: $eventName -> $data');
      _socket?.emit(eventName, data);
    } else {
      debugPrint('❌ Failed to emit: $eventName. Socket not connected.');
    }
  }

  ///<------------------------- Listen to Event ------------------------->  
  static void listen(String eventName, Function(dynamic) callback) {
    if (!isConnected()) {
      debugPrint('⚠️ Cannot listen to $eventName. Socket not connected.');
      return;
    }

    _socket?.off(eventName); // Remove previous listener (if any)
    _socket?.on(eventName, (data) {
      debugPrint('🔔 [$eventName] -> $data');
      callback(data);
    });
  }

  ///<------------------------- Disconnect & Cleanup ------------------------->  
  static void dispose() {
    debugPrint('🛑 Disconnecting socket...');
    if (_socket != null && _socket!.connected) {
      _socket?.disconnect();
    }
    _socket?.dispose();
    _socket = null;
  }
}
