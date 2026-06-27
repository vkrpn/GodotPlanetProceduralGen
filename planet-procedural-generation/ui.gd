extends Control
signal generate(noise_freq,ampl,rad,segments,rings,c1,c2,c3,c4,cc)

func _on_button_button_up() -> void:
	print($NoiseFrequency.text)
	generate.emit(int($NoiseFrequency.text),int($Amplitude.text),int($Radius.text),int($RadialSegments.text),int($SphereRings.text),string_to_color($Color1.text),string_to_color($Color2.text),string_to_color($Color3.text),string_to_color($Color4.text),string_to_color($CloudColor.text))

func string_to_color(text):
	var parts = text.split(",")
	
	return Color(
		parts[0].to_float(),
		parts[1].to_float(),
		parts[2].to_float(),
		parts[3].to_float()
	)
