//
//  3DAnimationViewController.swift
//  testisim
//
//  Created by Ahmet Can on 19.08.2018.
//  Copyright © 2018 Testisim. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var animationScene: SCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepeareAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func prepeareAnimation() {
        
        let scene = SCNScene(named: "testiscat.scnassets/Testis.scn")!
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 80)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 80)
        scene.rootNode.addChildNode(lightNode)
        
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
    
        animationScene.scene = scene
        animationScene.allowsCameraControl = true
    
    }
}
