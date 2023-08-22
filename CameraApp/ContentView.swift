import SwiftUI

struct ContentView: View {
    var cameraManager = CameraManager()
    
    var body: some View {
        VStack {
            Spacer()
            CameraPreviewView(cameraManager: cameraManager)
                .frame(height: UIScreen.main.bounds.height * 0.8)
            Spacer()
            HStack(spacing: 20) {
                Button(action: {
                    cameraManager.toggleFlashlight()
                }) {
                    VStack {
                        Image(systemName: "bolt.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("Flashlight")
                    }
                }
                Button(action: {
                    cameraManager.toggleVocalProcessing()
                }) {
                    VStack {
                        Image(systemName: "waveform")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("Vocals")
                    }
                }
                Button(action: {
                    cameraManager.capturePhoto { image in
                        // Handle the captured image if needed
                    }
                }) {
                    VStack {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        Text("Capture")
                    }
                }
            }
            .padding()
        }
    }
}


