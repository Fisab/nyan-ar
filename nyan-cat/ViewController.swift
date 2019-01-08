//
//  ViewController.swift
//  nyan-cat
//
//  Created by Влад Судаков on 07/01/2019.
//  Copyright © 2019 Влад Судаков. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var nyanImage: UIImageView!
    @IBOutlet var sceneView: ARSCNView!
    
    var pressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.scene = SCNScene()
        
        nyanImage.image = UIImage(named: "nyan")

        nyanImage.isUserInteractionEnabled = true
        let pressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handlePress))
        nyanImage.addGestureRecognizer(pressGestureRecognizer)
        
//        Place sphere at 0,0,0 for test
//        let ball = SCNSphere(radius: 0.5)
//
//        let material = SCNMaterial()
//        material.diffuse.contents = UIImage(named: "rainbow")
//        ball.materials = [material]
//
//        let ballNode = SCNNode(geometry: ball)
//        ballNode.position = SCNVector3(0, 0, 0)
//
//        sceneView.scene.rootNode.addChildNode(ballNode)
    }
    
    @objc func handlePress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            pressed = true
        }
        else if sender.state == UIGestureRecognizer.State.ended {
            // handle end of pressing
            pressed = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
        guard let pointOfView = sceneView.pointOfView else { return }

        if pressed == true {
            let ball = SCNSphere(radius: 0.075)
            
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "rainbow")
            ball.materials = [material]
            
            let ballNode = SCNNode(geometry: ball)
            ballNode.position = pointOfView.position
            
            sceneView.scene.rootNode.addChildNode(ballNode)
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
