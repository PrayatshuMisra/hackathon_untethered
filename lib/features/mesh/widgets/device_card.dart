import 'package:flutter/material.dart';
import '../../../core/providers/mesh_provider.dart';
import '../../../core/theme/app_theme.dart';

class DeviceCard extends StatelessWidget {
  final MeshDevice device;
  final VoidCallback onConnect;

  const DeviceCard({
    super.key,
    required this.device,
    required this.onConnect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
            ? AppTheme.glassBackground
            : AppTheme.glassBackgroundDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: device.isConnected
              ? AppTheme.primaryBlue.withOpacity(0.3)
              : AppTheme.primaryBlue.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Device Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: device.isConnected
                    ? AppTheme.primaryBlue.withOpacity(0.1)
                    : AppTheme.primaryBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getDeviceIcon(device.name),
                color: device.isConnected
                    ? AppTheme.primaryBlue
                    : AppTheme.primaryBlue.withOpacity(0.5),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Device Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device.name,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppTheme.darkBlue
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    device.ipAddress,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.primaryBlue.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.signal_wifi_4_bar,
                        size: 16,
                        color: _getSignalColor(device.signalStrength),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${device.signalStrength}%',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: _getSignalColor(device.signalStrength),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Connect Button
            if (!device.isConnected)
              ElevatedButton(
                onPressed: onConnect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Connect'),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.primaryBlue.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Connected',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getDeviceIcon(String deviceName) {
    if (deviceName.toLowerCase().contains('phone')) {
      return Icons.phone_android;
    } else if (deviceName.toLowerCase().contains('tablet')) {
      return Icons.tablet_android;
    } else if (deviceName.toLowerCase().contains('laptop')) {
      return Icons.laptop;
    } else if (deviceName.toLowerCase().contains('computer')) {
      return Icons.computer;
    } else {
      return Icons.devices_other;
    }
  }

  Color _getSignalColor(int signalStrength) {
    if (signalStrength >= 80) {
      return Colors.green;
    } else if (signalStrength >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
} 