extends Control
signal generate(noise_freq,ampl,rad,segments,rings,c1,c2,c3,c4,cc)

var warning1 = false

var noise_freq
var ampl
var rad
var segments
var rings
var c1
var c2
var c3
var c4
var cc

func _on_button_button_up() -> void:
	print($NoiseFrequency.text)
	noise_freq = int($NoiseFrequency.text)
	ampl = int($Amplitude.text)
	rad = int($Radius.text)
	segments = int($RadialSegments.text)
	rings = int($SphereRings.text)
	c1 = string_to_color($Color1.text)
	c2 = string_to_color($Color2.text)
	c3 = string_to_color($Color3.text)
	c4 = string_to_color($Color4.text)
	cc = string_to_color($CloudColor.text)
	if segments + rings > 3072:
		warning1 = true
		$Button2.visible = true
	else:
		$Button.text = "Working... (may take a while)"
		generate.emit(noise_freq,ampl,rad,segments,rings,c1,c2,c3,c4,cc)

func _on_button_2_button_up():
	$Button2.visible = false
	generate.emit(noise_freq,ampl,rad,segments,rings,c1,c2,c3,c4,cc)

func _process(delta):
	$ColorRect.color = Color($Red.value,$Green.value,$Blue.value,$Alpha.value)
	$Label12.text = str($ColorRect.color)

func string_to_color(text):
	var parts = text.split(",")
	
	return Color(
		parts[0].to_float(),
		parts[1].to_float(),
		parts[2].to_float(),
		parts[3].to_float()
	)
	
