//
//  ViewController.swift
//  AR Ruler
//
//  Created by Kamil Suwada on 19/04/2022.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: sceneView) {
            if let hit = sceneView.hitTest(location).first {
                addDot(at: hit)
            }
            
        }
    }
    
    
    private func addDot(at hit: SCNHitTestResult) {
        let sphere = SCNSphere(radius: 0.005)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.blue
        
        sphere.materials = [material]
        
        let dotNode = SCNNode(geometry: sphere)
        
        dotNode.position = hit.worldCoordinates
        
        sceneView.scene.rootNode.addChildNode(dotNode)
    }
    
    
}
