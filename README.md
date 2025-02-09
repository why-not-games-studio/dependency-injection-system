# Simple Dependency Injection 
 ![image](https://raw.githubusercontent.com/why-not-games-studio/dependency-injection-system/origin/master/simple_dependency_injection_logo.png)

 A simple Dependency Injection implementation for Godot 4 made with GDScript.

## Get Started
**1.** Go to **Project > Project Settings > Plugins** and ensure that the "Simple Dependency Injection" plugin is enabled.
   
   ![image](https://github.com/user-attachments/assets/d32dc005-55f4-494b-aea8-d7f81284b481)

**2.** Right-click on your main scene, click on the "Add Child Node" button, in the search bar, type "Dependency", select the [DependencyProvider], then click on the "Create" button.

   ![image](https://github.com/user-attachments/assets/107ac872-8475-492f-9369-c1f7f8b593de)

   ![Hierarchy](https://github.com/user-attachments/assets/eae8b2c6-096f-4bca-8909-c45838fff54e)

**3.** Now click on your created [DependencyProvider] and in the Inspector, under Members, click on the "Dependencies" array to expand it, click on the "Add Element" button, then assign your dependencies.

   ![DP Inspector](https://github.com/user-attachments/assets/a227541d-809c-4236-8031-e42654cd7408)

**4.** Right-click on any scene where you wish to inject dependencies into, click on the "Add Child Node" button, in the search bar, write 'dependency', select the [DependencyInjectionRequester], then click on the "Create" button.
   
   ![image](https://github.com/user-attachments/assets/92c7af6d-9667-425b-99b0-db5fa75296df)

   ![image](https://github.com/user-attachments/assets/815d412e-d8b3-4d2a-89a5-694e2c53c321)

**5.** Now to use it, in any scene with a [DependencyInjectionRequester] node, create any node, attach a script to it, and ensure that the script has a function named "_inject" for it to work. If you don't like the "_inject" function name, just change it in the [DependencyProvider] script.

   ![Full Test Receiver](https://github.com/user-attachments/assets/5ccf27e1-2a62-4a82-b8b7-56c17b10ef2d)
