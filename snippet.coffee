# UN-COMMENT EACH STEP IN ORDER TO SEE THE PROGRESSION OF THE EXAMPLE
# (UN-COMMENT BY HIGHLIGHTING THE TEXT AND PRESSING CMD + /)


# ----------------------------- STEP 1: CONSTRAINTS

# Try resizing the canvas!

layer1 = new Layer
	backgroundColor: "#fcbb4d"
	x: Align.center()

layer1.constraints =
	left: 50, right: 50
	top: 50
	height: 100
	aspectRatioLocked: true

# USING FUNCTION, - ALL POSSIBLE INPUTS

# layer1.setConstraints
# 	left: 20, right: 20
# 	top: 20, bottom: 20
# 	widthFactor: 0.5, heightFactor: 0.5
# 	centerAnchorX: 0.5, centerAnchorY: 0.5
# 	width: 200, height: 200
# 	aspectRatioLocked: false
#	minWidth: 200, minHeight: 200
#	maxWidth: 400, maxHeight: 400


# ----------------------------- STEP 2: PINNING

# layer2 = new Layer
# 	backgroundColor: "#ccafbd"
# layer2.constraints =
# 	minHeight: 200
# layer2.pins =
# 	y:
# 		layer: layer1
# 		value: 20
# 	x:
# 		layer: layer1
# 		side: "left"
# 	width:
# 		layer: layer1
# 	height:
# 		layer: layer1



# USING FUNCTION, - OTHER INPUTS

# layer2.setPins
# 	y:
# 		layer: layer1
# 		side: "top"
# 		value: 50
# 	maxX:
# 		layer: layer1
# 		side: "right"
# 		value: 50
# 	height:
# 		layer: layer1
# 		value: -100


# ----------------------------- STEP 3: PUSH PARENT

# layer3 = new Layer
# 	backgroundColor: "#aaccbb"
# 	height: 50
# textLayer = new TextLayer
# 	parent: layer3
# 	fontSize: 24
# 	color: "#444"
# 	text: "{content}"
# textLayer.template =
# 	content: "Tap me!"
# textLayer.constraints =
# 	top: 10
# 	left: 10
# 	right: 10
# textLayer.autoSize = true

# layer3.pins =
# 	y:
# 		layer: layer2
# 		value: 20
# 	x:
# 		layer: layer2
# 		side: "left"
# 	width: layer: layer2

# textLayer.pushParent
# 	direction: "down"
# 	value: textLayer.constraints.top

# textString = "This is a demo string that hopefully resizes the parent while it is animating in."
# speed = 0.05

# layer3.onTap ->
# 	for i in [0..textString.length]
# 		do (i) ->
# 			Utils.delay i*speed, ->
# 				textLayer.template =
# 					content: textString.slice 0, i