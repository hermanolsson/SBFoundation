# SBFoundation
Categories, classes and functions for iOS projects.

Yes, yes, I know, yet another collection of ObjC categories.
## Instructions
SBFoundation use the "Real" [iOS Universal Framework](https://github.com/kstenerud/iOS-Universal-Framework). This is because it should be very easy to both develop and ship as a binary. For building the FW you then need to patch your Xcode installation, however, I will try to release a compiled ready-to-rock version for every major version.

Make sure your target already links with:

* CoreText.framework

### Workspace
1. [Modify your Xcode installation](https://github.com/kstenerud/iOS-Universal-Framework)
2. clone / add submodule `https://blommegard@github.com/blommegard/SBFoundation.git`
3. Add *SBFoundation.xcodeproj* to your workspace
4. Link your target with the *SBFoundation.framework*, it should show up beneth the Workspace-section when adding a new library to a target
5. Add `-ObjC` & `-all_load` to your *Other Linker Flags*, under *Build Settings*
6. Import header files: `#import <SBFoundation/SBFoundation.h>`

### Stand-alone
1. Download the *SBFoundation.framework* from github
2. Add it to your project and link your target with it
3. Add `-ObjC` & `-all_load` to your *Other Linker Flags*, under *Build Settings*
4. Import header files: `#import <SBFoundation/SBFoundation.h>`

Both ways works for simulator & device.

## Features

* TBI

## External
* [MAKVONotificationCenter](https://github.com/mikeash/MAKVONotificationCenter)

## License
SBFoundation is released under the MIT-license (see the LICENSE file)
