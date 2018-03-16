# ---------------------------------------
# CONSTANTS & VARIABLES
# ---------------------------------------

defaultConstraints =
	left: 0
	right: null
	top: 0
	bottom: null
	centerAnchorX: null
	centerAnchorY: null
	widthFactor: null
	heightFactor: null
	aspectRatioLocked: false


# ---------------------------------------
# OBJECT MANIPULATION
# ---------------------------------------

Object.defineProperty(Layer.prototype, "constraints", {

	get: -> return @_constraints
	set: (value) ->
		@_constraints = value
		@setConstraints value
		@emit "change:constraints", value

});

Object.defineProperty(Layer.prototype, "pins", {

	get: -> return @_pins
	set: (value) ->
		@_pins = value
		@setPins value
		@emit "change:pins", value

});


# ---------------------------------------
# HELPER FUNCTIONS
# ---------------------------------------

getPropFromSide = (side) ->
	switch side
		when "left" then return "x"
		when "right" then return "maxX"
		when "top" then return "y"
		when "bottom" then return "maxY"

getAddOnFromKey = (key) ->
	switch key
		when "maxX" then return "width"
		when "maxY" then return "height"
		when "x" then return "width"
		when "y" then return "height"

getRefFromDirection = (dir) ->
	switch dir
		when "down"
			return {
				pos: "y"
				extra: "height"
				ref: "maxY"
			}
		when "right"
			return {
				pos: "x"
				extra: "width"
				ref: "maxX"
			}

setPinProps = (layer, key, object) ->
	if !object.layer?
		Utils.throwInStudioOrWarnInProduction "Make sure every pinned property has a layer associated with it."
	object.value ?= 0
	if key.includes "max"
		object.value = -object.value
		object.addOn = getAddOnFromKey key
	if key.includes "x" then object.side ?= "right"
	if key.includes "maxX" then object.side ?= "left"
	if key.includes "y" then object.side ?= "bottom"
	if key.includes "maxY" then object.side ?= "top"
	if object.side is "bottom" or object.side is "right"
		object.addOn = getAddOnFromKey key

	refProp = getPropFromSide(object.side) || key
	layer[key] = object.layer[refProp] + object.value

	object.layer.onChange key, ->
		layer[key] = @[refProp] + object.value
	if object.addOn?
		object.layer.onChange object.addOn, ->
			layer[key] = @[refProp] + object.value

# ---------------------------------------
# FUNCTIONS
# ---------------------------------------

Layer::setPins = (pins={}) ->
	layer = @

	for key, object of pins
		do (key, object) ->
			setPinProps layer, key, object

	layer.layout()


Layer::setConstraints = (constraints={}) ->
	layer = @

	layerDefaults = _.assign {}, [
		defaultConstraints,
		{
			left: constraints.left || if constraints.centerAnchorX then null
			top: constraints.top || if constraints.centerAnchorY then null
			width: layer.width
			height: layer.height
		}
	]


	layer.constraintValues = _.assign layerDefaults, constraints

	layer.layout()
	layer.states.default = layer.props


Layer::pushParent = (options={}) ->
	layer = @

	if !layer.parent?
		Utils.throwInStudioOrWarnInProduction "Layer must have a parent layer in order to increase it's size."

	ref = getRefFromDirection options.direction
	parent = layer.parent

	options.value ?= parent[ref.extra] - layer[ref.ref]
	options.direction ?= "down"

	parent[ref.extra] = layer[ref.ref] + options.value

	for reference in [ref.pos, ref.extra]
		do (reference) ->
			layer.onChange reference, ->
				parent[ref.extra] = layer[ref.ref] + options.value
