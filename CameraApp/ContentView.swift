import SwiftUI

struct ContentView: View {
    var cameraManager = CameraManager()
    
    var body: some View {
        VStack {
            Spacer()
            CameraPreviewView(cameraManager)
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
                            .frame(width: 40, height: 40) // smaller image size
                            .padding(10) // smaller padding
                        Text("Flashlight")
                            .font(.system(size: 14)) // smaller font size
                    }
                }
                Button(action: {
                    cameraManager.toggleVocalProcessing()
                }) {
                    VStack {
                        Image(systemName: "waveform")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40) // smaller image size
                            .padding(10) // smaller padding
                        Text("Vocals")
                            .font(.system(size: 14)) // smaller font size
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
                            .frame(width: 40, height: 40) // smaller image size
                            .padding(10) // smaller padding
                        Text("Capture")
                            .font(.system(size: 14)) // smaller font size
                    }
                }
            }
            .padding(.bottom, 50) // increased padding at the bottom
        }
    }
}
