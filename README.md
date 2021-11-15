# TryOn
## Eyewear fitting app

App purpose is to let users try out an eyewear using AR on supported iOS device. Requirements are gathered from the features document, analyzed by researching the doability of the core AR feature, a suitable architecture, necessary components and external dependencies that can help in the development process.

To guide the app requirements towards a production goal, communication with different teams is necessary. Information flow starts from the product team discussing the app idea and developing requirements with developers, designers & content creators. Later more communication is required to decide on details like
- Endpoints to retrieve the 3d models, discussed with backend team
- Format and structure of files to be loaded and their suitability in delivering target quality, meeting rendering engine requirements, and ease of load and processing on devices. Mostly discussed with content creators and can include backend team.
- There is often communication with the design team regarding the implementation of the UI/UX part. Product team to be included if there are any proposed changes.
- After implementation is finished, several quality assurance steps are taken starting with code reviews, often includes communication with other developers. Then features are handed to the testing team to assure functional quality, also product and design teams are notified, usually through the tickets board so they can participate in the testing as well.
- After acceptance, features are merged into the master branch waiting for releasing. 
- Release candidates and individual features testing usually follow a CI workflow. Tools like App Center builds and distributes to TestFlight so the app can be tested at different stages with ease.

### Technical notes
App follows a VIP architectural pattern. Business use case, GetEyewearModel, along with the Eyewear model are in the center and other components like Networking/Unarchiver/File/UI are dependent on them through protocols defined inside the use cases boundary.

For now, the business layer is almost empty as the demo is focused mostly on network loading and visualization. This layer should include different use cases the app provides and reflects business side requirements.

AppAssembler.swift is the DI container where all components are created and dependencies are injected. Composition root is in SceneDelegate.swift.

Networking/File/Unarchiver components follow a ports/adapter design pattern, making it easy to switch the implementation without requiring changes in other application components.

Interactions component makes use of the observable design pattern provided by Combine framework. It's intention is to isolate a user interaction from changes that should happen based on it. Allowing the presentation logic to be testable.

### External dependencies are installed via SPM.

- SnapKit | for layout of UIKit views.
- Alamofire | for networking.
- ZipArchive | for extracting downloaded zip model files.
- GLTFSceneKit | for loading and parsing a .gltf file into a SceneKit node graph.

### SPM over CocoaPods or Carthage
- CocoaPods takes more control over projects than what is needed from a dependency manager, like managing the project workspace.
- Carthage is simpler and cleaner, but has been historically slower at adopting changes like static and xc frameworks
- SPM is integrated in XCode, could install all required dependencies, worked like a charm without any extra efforts.


## Areas of improvement
- AR feature implementation is primitive and using an out of the box ARKit technologies. Eyewear handles can sometimes be seen through eyes holes of the default provided face geometry used for occlusion. Also detection around the edges of the face geometry is bad, spaces can be seen between the frame and face. Solutions can focus on improving face geometry deformation quality so it better fits the face topology.
- Also maybe a full head mesh, or band like added to the face geometry, including the ears, and fitted on the user's head can give better occlusion when side looking. Something along the lines of 3d Scanning apps that can generate a geometry.
- Error handling is present up to the point of transforming app level errors into config defined strings in the presenter layer. However no UI is provided for displaying of such error messages.
- Testing provided is meant to serve as an example and not full coverage. Requesting a 3d model code path is covered along with some of the presentation logic.

## Notes on compatibility
The App requires iOS 13 or later, mainly for the use of Combine framework. Core features can compile back to iOS 11.
Minimum hardware requirements for the AR feature is an A12 or later iOS/iPadOS device, including iPhone SE. App has been tested on an iPad pro 2020, and the iPhone UI in simulator.

