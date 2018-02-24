//
//  FrameExtractor.swift
//  Alamofire
//
//  Created by Sky Xu on 2/22/18.
//

import UIKit
import AVFoundation

protocol FrameExtractorDelegate: class {
    func captured(image: UIImage)
}

class FrameExtractor: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var imgFrames = [UIImage]()
//    set capture camera to be font
    private let position = AVCaptureDevice.Position.front
//    set quality of the video
    private let quality = AVCaptureSession.Preset.medium
    var queue = DispatchQueue(label: "sample buffer")
    
    private var permissionGranted = false
//    use serial queue, so we won't block the main thread
    private let sessionQueue = DispatchQueue(label: "session queue")
    
//    create instance of the class
    private let captureSession = AVCaptureSession()
    
//    we create a context eveytime we convert a buffer into image
    private let context = CIContext()
    
    weak var delegate: FrameExtractorDelegate?
    
    override init() {
        super.init()
//        check if camera is permiteed as soon as we create the object
        checkPermission()
        sessionQueue.async { [unowned self] in
//            once our user allowed for capture screen, we configure video session
            self.configureSession()
// once configure finished, run the capture session function
            self.captureSession.startRunning()
        }
}

// MARK: AVSession configuration
    private func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
        case .authorized:
            permissionGranted = true
        case .notDetermined:
            requestPermission()
        default:
            permissionGranted = false
        }
    }
    
    func stopSession() {
        self.captureSession.stopRunning()
    }
    
    private func requestPermission() {
        
//        since REQUESTACCESS CALL is asyncronus, we need to suspend session queue, and resume it once we get a respond from user
        sessionQueue.suspend()
//        here in case inside of the closure self woule be retained,
//     !   use weak when it is not implicit that self outlives the closure, but here we know it won't, so use unowned instead of weak
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [unowned self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
}

    private func configureSession() {
        guard permissionGranted else { return }
        captureSession.sessionPreset = quality
        guard let captureDevice = selectCaptureDevice() else { return }
//        make sure that device can be opened
        //        MARK: Output configure
        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        guard captureSession.canAddInput(captureDeviceInput) else { return }
        captureSession.addInput(captureDeviceInput)
        
        //        MARK: Output configure
        let videoOutput = AVCaptureVideoDataOutput()
//        set video output DELEGATE to be this FrameExtrator class
        videoOutput.setSampleBufferDelegate(self, queue: queue)
//        add the frame we received from video
        guard captureSession.canAddOutput(videoOutput) else { return }
        captureSession.addOutput(videoOutput)
        guard let connection = videoOutput.connection(with: AVFoundation.AVMediaType.video) else { return }
        guard connection.isVideoOrientationSupported else { return }
        guard connection.isVideoMirroringSupported else { return }
        connection.videoOrientation = .portrait
        connection.isVideoMirrored = position == .front
    }
    
//    check if the devise is able to capture video, and the position of camera is front
    private func selectCaptureDevice() -> AVCaptureDevice? {
//        AVCaptureDevice.devices()
        return AVCaptureDevice.devices().filter {
            ($0 as AnyObject).hasMediaType(AVMediaType.video) &&
                ($0 as AnyObject).position == position
            }.first as? AVCaptureDevice
     
    }

    // MARK: Sample buffer to UIImage conversion
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> UIImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
    // MARK: AVCaptureVideoDataOutputSampleBufferDelegate
//    being called eveytime a new frame become available
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let uiImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        
        // every frame processing must be done on this queue.
        DispatchQueue.main.async { [unowned self] in
            //            CALL THE PROCOTOL FUNCTION
            self.delegate?.captured(image: uiImage)
        }
        imgFrames.append(uiImage)
    }
}

