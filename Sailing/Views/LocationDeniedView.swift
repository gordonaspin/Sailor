import SwiftUI

struct LocationDeniedView: View {
    var body: some View {
        ContentUnavailableView(
            
            label: {
                Image("launchScreen")
                    .resizable()
                    .frame(width: 150, height: 150)
                Text("Location Services Denied")
            },
            description: {
                Text(
                    """
                    1. Tab the button below and go to "Privacy and Security"
                    2. Tap on "Location Services"
                    3. Locate the "Sailor" app and tap on it
                    4. Change the setting to "While Using the App"
                    """
                )
                .multilineTextAlignment(.leading)
            },
            actions: {
                Button(
                    action: {
                        UIApplication.shared.open(
                            URL(string: UIApplication.openSettingsURLString)!,
                            options: [:],
                            completionHandler: nil
                        )
                    }
                )
                {
                    Text("Open Settings")
                }
                .buttonStyle(.borderedProminent)
            }
        )
    }
}

#Preview {
    LocationDeniedView()
}
