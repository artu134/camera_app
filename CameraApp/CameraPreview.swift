import SwiftUI

struct CameraPreviewView: UIViewRepresentable {
    var cameraManager: CameraManager
    
    func makeUIView(context: Context) -> UIView {
       let view = UIView(frame: UIScreen.main.bounds)
       cameraManager.previewLayer?.frame = view.frame
       if let previewLayer = cameraManager.previewLayer {
           view.layer.addSublayer(previewLayer)
       }
       return view
   }
       
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the view as needed
    }
}
