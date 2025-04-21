package com.example.car_rental;

import io.flutter.app.FlutterApplication;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.security.ProviderInstaller;
import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;

public class CarRentalApplication extends FlutterApplication {
    private static final String TAG = "CarRentalApplication";

    @Override
    public void onCreate() {
        super.onCreate();
        
        // Initialize the security provider
        initializeSecurityProvider(this);
    }

    private void initializeSecurityProvider(final Context context) {
        AsyncTask.execute(new Runnable() {
            @Override
            public void run() {
                try {
                    // This call installs the proper security provider
                    ProviderInstaller.installIfNeeded(context);
                    Log.i(TAG, "ProviderInstaller installed successfully");
                } catch (GooglePlayServicesRepairableException e) {
                    // Indicates that Google Play services is out of date, disabled, etc.
                    Log.e(TAG, "GooglePlayServicesRepairableException: " + e.getMessage());
                } catch (GooglePlayServicesNotAvailableException e) {
                    // Indicates a non-recoverable error; Google Play services is not available
                    Log.e(TAG, "GooglePlayServicesNotAvailableException: " + e.getMessage());
                } catch (Exception e) {
                    // General exception handling for any other issues
                    Log.e(TAG, "Unexpected error initializing provider: " + e.getMessage());
                }
            }
        });
    }
}