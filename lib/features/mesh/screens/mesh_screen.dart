import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/mesh_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/device_card.dart';
import '../widgets/qr_code_dialog.dart';

class MeshScreen extends StatelessWidget {
  const MeshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesh Network'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<MeshProvider>().refreshDevices();
            },
          ),
        ],
      ),
      body: Consumer<MeshProvider>(
        builder: (context, meshProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Status Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: meshProvider.isEnabled
                        ? AppTheme.secondaryTeal.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: meshProvider.isEnabled
                          ? AppTheme.secondaryTeal.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        meshProvider.isEnabled
                            ? Icons.wifi_tethering
                            : Icons.wifi_off,
                        color: meshProvider.isEnabled
                            ? AppTheme.secondaryTeal
                            : Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mesh Status',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: meshProvider.isEnabled
                                    ? AppTheme.secondaryTeal
                                    : Colors.grey,
                              ),
                            ),
                            Text(
                              meshProvider.connectionStatus,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: meshProvider.isEnabled
                                    ? AppTheme.secondaryTeal.withOpacity(0.7)
                                    : Colors.grey.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: meshProvider.isEnabled,
                        onChanged: (value) => meshProvider.toggleMesh(),
                        activeColor: AppTheme.secondaryTeal,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Connected Device Info
                if (meshProvider.connectedDevice != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primaryBlue.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.devices,
                          color: AppTheme.primaryBlue,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Connected to ${meshProvider.connectedDevice!.name}',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryBlue,
                                ),
                              ),
                              Text(
                                meshProvider.connectedDevice!.ipAddress,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.primaryBlue.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Disconnect
                          },
                          icon: const Icon(Icons.close),
                          color: AppTheme.primaryBlue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Nearby Devices
                Row(
                  children: [
                    Text(
                      'Nearby Devices',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    if (meshProvider.isScanning)
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Devices List
                Expanded(
                  child: meshProvider.nearbyDevices.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.devices_other,
                                size: 64,
                                color: AppTheme.primaryBlue.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No devices found',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppTheme.primaryBlue.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Make sure other devices have Mesh enabled',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppTheme.primaryBlue.withOpacity(0.5),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: meshProvider.nearbyDevices.length,
                          itemBuilder: (context, index) {
                            final device = meshProvider.nearbyDevices[index];
                            return DeviceCard(
                              device: device,
                              onConnect: () => meshProvider.connectToDevice(device),
                            );
                          },
                        ),
                ),

                // Action Buttons
                if (meshProvider.isEnabled) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showQRCodeDialog(context, meshProvider.generateQRCode());
                          },
                          icon: const Icon(Icons.qr_code),
                          label: const Text('Show QR Code'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showFileShareDialog(context, meshProvider);
                          },
                          icon: const Icon(Icons.share),
                          label: const Text('Share File'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondaryTeal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showQRCodeDialog(BuildContext context, String qrData) {
    showDialog(
      context: context,
      builder: (context) => QRCodeDialog(qrData: qrData),
    );
  }

  void _showFileShareDialog(BuildContext context, MeshProvider meshProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share File'),
        content: const Text('Select a file to share with connected device'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Simulate file sharing
              meshProvider.shareFile('/path/to/sample/file.pdf');
              Navigator.of(context).pop();
            },
            child: const Text('Share'),
          ),
        ],
      ),
    );
  }
} 