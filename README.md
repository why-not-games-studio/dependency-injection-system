# Dependency Injection System
 A simple DI implementation for Godot 4 made with GDScript.

## Get Started
1. Go to Project Settings > Globals > Autoload, click on the small folder icon, navigate to the dependency-injection-system folder, select the file named dependency_provider_interface.gd and click the "Open" button, rename the "Node Name" to "IDependencyProvider" then finally click on the "Add" button.
![Autoloads](https://github.com/user-attachments/assets/f5c9d3c8-adba-4590-8793-e5e5c82882ed)

2. Right-click on your main scene, click on the "Add Child Node" button, in the search bar, type "Dependency", select DependencyProvider, then click on the "Create" button.
![Node Search Dependency](https://github.com/user-attachments/assets/b35d1350-d288-4290-8da0-c42b6a779c8d)
![Hierarchy](https://github.com/user-attachments/assets/eae8b2c6-096f-4bca-8909-c45838fff54e)

3. Now click on your created DependencyProvider and in the Inspector, under Members, click on the Dependencies array to expand it, click on the "Add Element" button, then assign your dependencies.
![DP Inspector](https://github.com/user-attachments/assets/a227541d-809c-4236-8031-e42654cd7408)

4. Right-click any scene where you wish to inject dependencies into, click on the "Add Child Node" button, in the search bar, write "Dependency", select DependencyInjector, then click on the "Create" button.
![DInjector Search Dependency](https://github.com/user-attachments/assets/1f513ffb-d3bd-4aee-892e-f917a2cd77c5)

5. Now click on your create DependencyInjector and in the Inspector, under Members, click on the DependencyNames array to expand it, click on the "Add Element" button, then write in every name of the dependencies your scripts need. If your script has a custom base class, you can enter that name instead as it is preferred but not required.
![DInjector Inspector](https://github.com/user-attachments/assets/5d6eb365-75cf-4987-a99b-8327044da3e5)
![Sub Hierarchy](https://github.com/user-attachments/assets/27e2148d-a7ec-4699-b5d7-2bfe54376c62)

6. Now to test it, in that same scene, create any node, attach a script to it, and ensure that the script has a function named "_inject" for it to work. If you don't like the "_inject" function name, just change it in the DependencyInjector script.![Full Test Receiver](https://github.com/user-attachments/assets/8529fd21-3e38-416f-bcdd-063900d4d980)
