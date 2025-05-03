# Simple Dependency Injection 
 ![image](https://raw.githubusercontent.com/why-not-games-studio/dependency-injection-system/origin/master/simple_dependency_injection_logo.png)

 A simple Dependency Injection implementation for Godot 4 made in GDScript.

## Important
- This is a node-based dependency injection system so all the dependencies have to extend from [Node].
- This tool will not create nor will it manage nodes, its job is to simply pass them to where they're needed.
- This tool was built with simplicity in mind and working with the engine, so it can easily integrate into different workflows.

## Known limitations
1. If you have a dependency node with an attached script that has a 'class_name', ensure that the name of the node in the scene tree is the same as the 'class_name' to avoid issues.

## Some use cases
1. You're in a situation where you do not have direct access (via @export) to the nodes you need in a script and do not wish to create a global singleton via autoload.
2. You want a form of dependency inversion and wish to rely on abstractions to interact with other parts of your code.
3. The nodes you need have their own in-scene dependencies that they need to have direct access (via @export) to.

## Get Started
**1.** Go to **Project > Project Settings > Plugins** and enable the "Simple Dependency Injection" plugin.
   
   ![image](https://github.com/user-attachments/assets/116f0c7d-2157-47a4-9a67-9621e4c1836e)

**2.** Now there should be two new nodes in your current opened scene, for visibility, you can place them at the very top of your scene tree hierarchy.

   ![image](https://github.com/user-attachments/assets/b1fa714e-694c-46d5-9beb-9c6fff5888b0)

**3.** Now click on the created [DependencyRegistrar] node and in the Inspector, click on the "Dependencies" array to expand it, click on the "Add Element" button, then assign your dependency nodes.

   ![image](https://github.com/user-attachments/assets/095d1562-baf8-46c8-bf55-8a2dab510e11) ![image](https://github.com/user-attachments/assets/9856479b-fdb1-45d2-92f1-ac023a2c1382)

**4.** Now to use it, create any node, attach any script to it, and to allow dependency injection to happen, simply create either an __inject_ function or a __post_inject_ function, or **both**! But do keep in mind that these are only called after _ready. (If you don't like the "_inject" or "_post_inject" function names, feel free to change them in the [DependencyProvider] script)

   ![image](https://github.com/user-attachments/assets/ff50942a-63bc-48e1-ab00-7a0cfbc0f397)
