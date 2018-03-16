# framer-constraints
Simple and Super Constraints for Framer!

### Links

* [Installation](#installation)
* [Constraints](#constraints)
* [Pin](#pin)
* [Push Parent](#push-parent)

## Installation

### Automatic installation with [Framer Modules](https://www.framermodules.com/)

<a href='https://open.framermodules.com/more-constraints'>
    <img alt='Install with Framer Modules'
    src='https://www.framermodules.com/assets/badge@2x.png' width='160' height='40' />
</a>

### Manual installation

Download and move the <code>Constraints.coffee</code> file to your modules folder.

At the top of your file, place this line of code:

```coffeescript
Constraints = require "Constraints"
```

Done! That is all the code you need to do to get this module started. Now onto the fun stuff.


## Constraints

### setConstraints(options)

```coffeescript
layer.setConstraints
  left: 20
  right: 20
  top: 20
  aspectRatioLocked: true
  maxWidth: 200
```

#### Arguments
* `left` – Fixed margin on left side of layer. (Default: `0`)
* `right` – Fixed margin on right side of layer. (Default: `null`)
* `top` – Fixed margin on top side of layer. (Default: `0`)
* `bottom` – Fixed margin on bottom side of layer. (Default: `null`)
* `widthFactor` (0 - 1) – Width ratio of layer:parent. (Default: `null`)
* `heightFactor` (0 - 1) – Height ratio of layer:parent. (Default: `null`)
* `centerAnchorX` (0 - 1) – Ratio of where the layer sits within parent on X-axis. (Default: `null`)
* `centerAnchorY` (0 - 1) – Ratio of where the layer sits within parent on Y-axis. (Default: `null`)
* `aspectRatioLocked` (bool) – Keep the aspect ratio on resize. (Default: `false`)
* `minWidth` – Minimum width for the layer. (Optional)
* `maxWidth` – Maximum width for the layer. (Optional)
* `minHeight` – Minimum height for the layer. (Optional)
* `maxHeight` – Maximum height for the layer. (Optional)

### layer.constraints

```coffeescript
layer.constraints =
  widthFactor: 0.8
  centerAnchorX: 0.5
  centerAnchorY: 0.1
```

You can also set the constraints on a layer like any other property. This must be done after the initialisation of the layer.


## Pin

### setPins(options)

```coffeescript
layer.setPins
  y:
    layer: referenceLayer
    side: "bottom"
    value: 20
  width:
    layer: referenceLayer
    value: -20
```

#### Arguments
* `position` (object) – Use the position as the key for each pin reference.
  * `x`, `y`, `maxX`, `maxY`
* `size` (object) – You can also pin the `width`, `height` or `size` of a layer to a reference layer.
* Object Arguments
  * `layer` – The layer to reference the pin to.
  * `side` (string) – The side to pin the layer to. ("top", "bottom", "left", "right")
    * Default for `x`: "right"
    * Default for `maxX`: "left"
    * Default for `y`: "bottom"
    * Default for `maxY`: "top"
  * `value` (number) – The offset of the pin from the edge. Negative values are allowed for a negative offset.
    * Default for position

### layer.pins

```coffeescript
layer.pins =
  x:
    layer: referenceLayer
    side: "left"
    value: -50
  y:
    layer: referenceLayer
    value: 10
  height:
    layer: referenceLayer
```


## Push Parent

### pushParent(options)

```coffeescript
layer.pushParent
  direction: "down"
  value: 20
```

#### Arguments
* `direction` (string) – The direction in which to push the size of the parent. (`"down"`, `"right"`)
* `value` (number) – The margin to add between the layer and the parent. (Default is the original margin upon calling the function).











