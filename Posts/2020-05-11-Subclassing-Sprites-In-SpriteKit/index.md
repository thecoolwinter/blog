---
title: Subclassing Sprites in SpriteKit
tags: [SpriteKit, Swift, iOS]
excerpt: Subclass a SKSpriteNode to make multiple types of the same sprite to save time and energy.
created_at: 2020-05-11
---
## Subclassing

Subclassing `SKSpriteNode`s makes it easy to have multiple classes of a similar sprite. One use case for this would be in a breakout-like game where there are multiple kinds of blocks that can do different things.

In this example we'll start with a normal `BlockNode`. Then, we'll subclass it to create a new type of block called `ExplosionNode`.

## Block Node

The code for the original block node looks like this.
```swift
class BlockNode: SKSpriteNode {
    
    var background: SKShapeNode?
    
    convenience init(size: CGSize) {
        self.init(texture: nil, color: .clear, size: size)
        
        background = SKShapeNode(rectOf: size, cornerRadius: 5)
        background!.fillColor = .darkGray
        background!.strokeColor = .lightGray
        addChild(background!)
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func endBlock() {
        guard let scene = self.scene as? GameScene else { self.removeFromParent(); return }       
        removeFromParent()
    }
    
}
```

This simple SKSpriteNode class creates a block with a grey background. It can be created using `BlockNode(size: CGSize())`. 

In the game when the ball touches the block, `endBlock()` is called to remove the block.

Now that we have a normal block lets make another, more fun, block.

## Explosion Block

We can easily subclass the `BlockNode` by adding it to the class definition of `ExplosionBlockNode` like so.
```swift
class ExplosionBlockNode: BlockNode {
	...
}
```

Now lets override the init function that makes the block grey, and instead make it red.

```swift
    convenience init(size: CGSize) {
        self.init(texture: nil, color: .clear, size: size)
        
		background = SKShapeNode(rectOf: size, cornerRadius: 5)
        background!.fillColor = .red
        background!.strokeColor = .darkGray
        addChild(background!)
    }
```

Now the block can be created using the same method as the normal block, except now using `ExplosionBlockNode(size: CGSize())`. This initializer will create a red block instead of a grey one.

We can also change the `endBlock()` function to being special for the explosion block by simply adding it to the `ExplosionBlockNode` like this.

```swift
    override public func endBlock() {
        guard let scene = self.scene as? GameScene else { self.removeFromParent(); return }

        let scoreLabel = SKLabelNode(text: "Boom")
        scoreLabel.color = .red
        scoreLabel.position = self.position
        scoreLabel.fontSize = 24
        scene.addChild(scoreLabel)
        scoreLabel.run(.sequence([.group([.moveTo(y: self.position.y + 50, duration: 0.4), .fadeOut(withDuration: 0.3)]), .removeFromParent()]))

        scene.addChild(field)
        field.run(SKAction.sequence([SKAction.wait(forDuration: 0.05),SKAction.removeFromParent()]))
        removeFromParent()
    }
```

Now when we call the `endBlock` method on the explosion block it'll add a little label saying "Boom" that fades quickly and animates up.

The final explosion block code looks like this.
```swift
class ExplosionBlockNode: BlockNode {

    convenience init(size: CGSize) {
        self.init(texture: nil, color: .clear, size: size)

        background = SKShapeNode(rectOf: size, cornerRadius: 5)
        background!.fillColor = .red
        background!.strokeColor = .darkGray
        addChild(background!)
    }

    override public func endBlock() {
        guard let scene = self.scene as? GameScene else { self.removeFromParent(); return }

        let scoreLabel = SKLabelNode(text: "Boom")
        scoreLabel.color = .red
        scoreLabel.position = self.position
        scoreLabel.fontSize = 24
        scene.addChild(scoreLabel)
        scoreLabel.run(.sequence([.group([.moveTo(y: self.position.y + 50, duration: 0.4), .fadeOut(withDuration: 0.3)]), .removeFromParent()]))

        scene.addChild(field)
        field.run(SKAction.sequence([SKAction.wait(forDuration: 0.05),SKAction.removeFromParent()]))
        removeFromParent()
    }

}
```
