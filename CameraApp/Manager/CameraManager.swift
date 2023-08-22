//
//  CameraManager.swift
//  CameraApp
//
//  Created by Elizabeth on 2023/8/22.
//

import AVFoundation
import Photos
import UIKit

class CameraManager: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate, AVCapturePhotoCaptureDelegate {
    
    var captureSession: AVCaptureSession?
       var previewLayer: AVCaptureVideoPreviewLayer?
       var flashlightOn: Bool = false
       var isProcessingVocals: Bool = false
       private var segmentation: SegmentsService?
       let photoOutput = AVCapturePhotoOutput()

       override init() {
           super.init()
           
           captureSession = AVCaptureSession()
               
           captureSession?.sessionPreset = .high
           
           guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
               print("Unable to access back camera!")
               return
           }
           
           do {
               let input = try AVCaptureDeviceInput(device: backCamera)
               captureSession?.addInput(input)
               
               let videoOutput = AVCaptureVideoDataOutput()
               videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
               captureSession?.addOutput(videoOutput)
               
               previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
               
               previewLayer?.videoGravity = .resizeAspectFill
               
               captureSession?.addOutput(photoOutput)
               
           } catch {
               print("Error Unable to initialize back camera: \(error.localizedDescription)")
           }
           
           captureSession?.startRunning()
       }
       
       func toggleFlashlight() {
           guard let device = AVCaptureDevice.default(for: .video) else { return }
           if device.hasTorch {
               do {
                   try device.lockForConfiguration()
                   if flashlightOn {
                       device.torchMode = .off
                   } else {
                       device.torchMode = .on
                   }
                   flashlightOn.toggle()
                   device.unlockForConfiguration()
               } catch {
                   print("Torch could not be used")
               }
           } else {
               print("Torch is not available")
           }
       }
       
       func capturePhoto(completion: @escaping (UIImage?) -> Void) {
           let settings = AVCapturePhotoSettings()
           photoOutput.capturePhoto(with: settings, delegate: self)
       }

       func toggleVocalProcessing() {
           isProcessingVocals.toggle()
       }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Here is where you process the video frames
        // Do any video processing you want with the sampleBuffer
        
        guard let result: SegmentationResult = segmentation?.segment(sampleBuffer) else {
                print("Cannot process")
                return
            }
        drawBox(result)
    }
    
    private func drawBox(_ result: SegmentationResult){
        
        /// Create the boundingbox over segmentated area
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                print("Error capturing photo: \(error)")
                return
            }
            
            guard let imageData = photo.fileDataRepresentation() else {
                return
            }
            
            let image = UIImage(data: imageData)
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image!)
            }, completionHandler: nil)
        }
}

