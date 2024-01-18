# SwiftUI ToggleDrawer

A SwiftUI bottom drawer that can display separate view content based on open or closed states.

<img src=https://raw.githubusercontent.com/nbrandes/ToggleDrawer/main/Docs/Media/ToggleDrawer.gif width=300 align="right" />

## Contents

- [Add the Package](#package)
- [Usage](#usage)
- [Example](#example)
- [Parameters](#parameters)

## Package

### For Xcode Projects

File > Swift Packages > Add Package Dependency: https://github.com/nbrandes/ToggleDrawer

### For Swift Packages

Add a dependency in your your `Package.swift`

```swift
.package(url: "https://github.com/nbrandes/ToggleDrawer.git"),
```

## Usage

Initialize ToggleDrawer with small and large drawer heights and a binding for isOpen. Then add views for large and small drawer states.

```swift                                                                                                                                            
ToggleDrawer(small: 180, large: 500, isOpen: $isOpen) {
    LargeView()
} smallView: {
    SmallView()
}

```

## Example

```swift
import SwiftUI
import ToggleDrawer

struct ContentView: View {
    
    @State var showDrawer = false
    
    var body: some View {
        Button("Toggle") { showDrawer = !showDrawer }
            .buttonStyle(.bordered)
        
        ToggleDrawer(small: 180, large: 500, isOpen: $showDrawer) {
            LargeView()
        } smallView: {
            SmallView()
        }
    }
}

struct SmallView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Small")
            Spacer()
        }
    }
}

struct LargeView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Large")
                .font(.largeTitle)
            Spacer()
        }
    }
}
```

## Parameters

ToggleDrawer can be initialized with the following parameters

Required:
* `small: CGFloat` - Visible height of the drawer in the closed state
* `large: CGFloat` - Visible height of the drawer in the open state
* `isOpen: Binding<Bool>` - Binding used to show/hide the drawer


Optional:
* `shadowColor: Color` - Color used for drop shadow
* `shadowRadius: CGFloat` - Radius used for drop shadow
* `cornerRadius: CGFloat` - Value used for topLeadingRadius and topTrailingRadius

```swift
ToggleDrawer(small: 180, 
             large: 500,
             isOpen: $showDrawer,
             shadowColor: .gray,
             shadowRadius: 8,
             cornerRadius: 32) {
    LargeView()
} smallView: {
    SmallView()
}
```
