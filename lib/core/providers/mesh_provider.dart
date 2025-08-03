import 'package:flutter/material.dart';
import 'dart:io';

class MeshDevice {
  final String id;
  final String name;
  final String ipAddress;
  final bool isConnected;
  final int signalStrength;

  MeshDevice({
    required this.id,
    required this.name,
    required this.ipAddress,
    this.isConnected = false,
    this.signalStrength = 0,
  });
}

class MeshProvider extends ChangeNotifier {
  bool _isEnabled = false;
  bool _isScanning = false;
  List<MeshDevice> _nearbyDevices = [];
  MeshDevice? _connectedDevice;
  List<String> _sharedFiles = [];
  String _connectionStatus = 'Not Connected';

  bool get isEnabled => _isEnabled;
  bool get isScanning => _isScanning;
  List<MeshDevice> get nearbyDevices => _nearbyDevices;
  MeshDevice? get connectedDevice => _connectedDevice;
  List<String> get sharedFiles => _sharedFiles;
  String get connectionStatus => _connectionStatus;

  void toggleMesh() {
    _isEnabled = !_isEnabled;
    if (_isEnabled) {
      _startScanning();
    } else {
      _stopScanning();
      _disconnect();
    }
    notifyListeners();
  }

  void _startScanning() {
    _isScanning = true;
    _connectionStatus = 'Scanning for devices...';
    notifyListeners();

    // Simulate device discovery
    Future.delayed(const Duration(seconds: 2), () {
      _nearbyDevices = [
        MeshDevice(
          id: 'device1',
          name: 'John\'s Phone',
          ipAddress: '192.168.1.101',
          signalStrength: 85,
        ),
        MeshDevice(
          id: 'device2',
          name: 'Sarah\'s Tablet',
          ipAddress: '192.168.1.102',
          signalStrength: 72,
        ),
        MeshDevice(
          id: 'device3',
          name: 'Office Laptop',
          ipAddress: '192.168.1.103',
          signalStrength: 45,
        ),
      ];
      _isScanning = false;
      _connectionStatus = 'Found ${_nearbyDevices.length} devices';
      notifyListeners();
    });
  }

  void _stopScanning() {
    _isScanning = false;
    notifyListeners();
  }

  Future<void> connectToDevice(MeshDevice device) async {
    _connectionStatus = 'Connecting to ${device.name}...';
    notifyListeners();

    // Simulate connection process
    await Future.delayed(const Duration(seconds: 2));

    _connectedDevice = device;
    _connectionStatus = 'Connected to ${device.name}';
    
    // Update device status
    final index = _nearbyDevices.indexWhere((d) => d.id == device.id);
    if (index != -1) {
      _nearbyDevices[index] = MeshDevice(
        id: device.id,
        name: device.name,
        ipAddress: device.ipAddress,
        isConnected: true,
        signalStrength: device.signalStrength,
      );
    }

    notifyListeners();
  }

  void _disconnect() {
    _connectedDevice = null;
    _connectionStatus = 'Not Connected';
    _nearbyDevices = _nearbyDevices.map((device) => MeshDevice(
      id: device.id,
      name: device.name,
      ipAddress: device.ipAddress,
      isConnected: false,
      signalStrength: device.signalStrength,
    )).toList();
    notifyListeners();
  }

  Future<void> shareFile(String filePath) async {
    if (_connectedDevice == null) {
      _connectionStatus = 'No device connected';
      notifyListeners();
      return;
    }

    _connectionStatus = 'Sharing file...';
    notifyListeners();

    // Simulate file sharing
    await Future.delayed(const Duration(seconds: 1));

    final fileName = filePath.split('/').last;
    _sharedFiles.add(fileName);
    _connectionStatus = 'File shared: $fileName';
    notifyListeners();
  }

  Future<void> shareMemory(String memoryId) async {
    if (_connectedDevice == null) {
      _connectionStatus = 'No device connected';
      notifyListeners();
      return;
    }

    _connectionStatus = 'Sharing memory...';
    notifyListeners();

    // Simulate memory sharing
    await Future.delayed(const Duration(seconds: 1));

    _sharedFiles.add('Memory_$memoryId.json');
    _connectionStatus = 'Memory shared';
    notifyListeners();
  }

  void clearSharedFiles() {
    _sharedFiles.clear();
    notifyListeners();
  }

  String generateQRCode() {
    // In a real app, this would generate a QR code with connection info
    return 'mesh://${_connectedDevice?.ipAddress ?? 'localhost'}/connect';
  }

  Future<void> refreshDevices() async {
    if (!_isEnabled) return;
    
    _isScanning = true;
    _connectionStatus = 'Refreshing devices...';
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    _startScanning();
  }
} 