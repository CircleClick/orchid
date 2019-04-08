import 'package:flutter/material.dart';
import 'package:orchid/api/orchid_api_real.dart';
import 'package:orchid/api/orchid_types.dart';
import 'package:rxdart/rxdart.dart';

///
/// Orchid App Channel API
///
abstract class OrchidAPI {
  static final OrchidAPI _singleton = new RealOrchidAPI();

  factory OrchidAPI() {
    return _singleton;
  }

  /// Publish the connection status.
  final BehaviorSubject<OrchidConnectionState> connectionStatus;

  /// Publish the synchronization status.
  final BehaviorSubject<OrchidSyncStatus> syncStatus;

  /// Publish the network route status.
  final BehaviorSubject<OrchidRoute> routeStatus;

  /// Publishes a status of true if the user has granted any necessary OS level permissions to allow
  /// installation and activation of the Orchid VPN networking extension.
  /// Note: On iOS this corresponds to having successfully saved the Orchid VPN configuration via the
  /// NEVPNManager API.
  final BehaviorSubject<bool> networkingPermissionStatus;

  /// Publish development logging information from the channel implementation to the application.
  /// The application will automatically subscribe to this stream and persist the messages to the
  /// app filesystem log which can be viewed and managed by the user.
  final PublishSubject<String> log;

  /// Trigger a request for OS level permission to allow installation and activation of the
  /// Orchid VPN networking extension, potentially causing the OS to prompt the user.
  /// Returns true if the permission was granted.
  /// Note: On iOS this corresponds to an attempt to save the Orchid VPN configuration via the
  /// NEVPNManager API.
  Future<bool> requestVPNPermission();

  /// Set or update the user's wallet info.
  /// Returns true if the wallet was successfully saved.
  /// TODO: Support more than one wallet?
  Future<bool> setWallet(OrchidWallet wallet);

  /// If a wallet has been configured this method returns the user-visible
  /// wallet info; otherwise this method returns null.
  Future<OrchidWalletPublic> getWallet();

  /// Set or update the user's external VPN config.
  /// Return true if the configuration was saved successfully.
  /// TODO: Support more than one VPN config?
  Future<bool> setExitVPNConfig(VPNConfig vpnConfig);

  /// If an extenral VPN has been configured this method returns the user-visible
  /// VPN configuration; otherwise this method returns null.
  Future<VPNConfigPublic> getExitVPNConfig();

  /// Enable or disable log messages from the channel implementation.
  Future<void> setLogging(bool enabled);

  /// Set the desired connection state: true for connected, false to disconnect.
  Future<void> setConnected(bool connect);

  /// Choose a new, randomized, network route.
  Future<void> reroute();

}

