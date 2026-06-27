extends Node3D
var planet_mdt = MeshDataTool.new()
var cloud_mdt = MeshDataTool.new()
var planet_mesh = ArrayMesh.new()
var cloud_mesh = ArrayMesh.new()
var noise = FastNoiseLite.new()

var material = StandardMaterial3D.new()
var cloud_material = StandardMaterial3D.new()

@onready var planet: MeshInstance3D = $Planet
@onready var clouds: MeshInstance3D = $Clouds

var sphere = SphereMesh.new()

var color1 = Color(0.001, 0.218, 1.0, 1.0)
var color2 = Color(0.0, 0.596, 0.0, 1.0)
var color3 = Color(0.333, 0.333, 0.333, 1.0)
var color4 = Color(1.0, 1.0, 1.0, 1.0)
var cloud_color = Color(1.0, 1.0, 1.0, 0.55)
var radius = 1
var amplitude = 0.05
var noise_frequency = 5
var radial_segments = 2048
var sphere_rings = 1024

func _ready():
	material.vertex_color_use_as_albedo = true
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	cloud_material.vertex_color_use_as_albedo = true
	cloud_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	planet.material_override = material
	clouds.material_override = cloud_material
	
	$Control.generate.connect(generate_planet)

func generate_planet(noise_freq,ampl,rad,segments,rings,c1,c2,c3,c4,cc):
	color1 = c1
	color2 = c2
	color3 = c3
	color4 = c4
	cloud_color = cc
	radius = rad
	amplitude = ampl
	noise_frequency = noise_freq
	radial_segments = segments
	sphere_rings = rings
	
	sphere.radial_segments = radial_segments
	sphere.rings = sphere_rings
	
	$Camera3D.position.z = 2 * radius
	
	planet_gen()
	cloud_gen()
	
func planet_gen():
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = noise_frequency
	
	var temp = ArrayMesh.new()
	temp.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, sphere.get_mesh_arrays())
	
	planet_mdt.create_from_surface(temp, 0)
	
	for i in range(planet_mdt.get_vertex_count()):
		var vertex = planet_mdt.get_vertex(i)
		var color = Color()
		
		var direction = vertex.normalized()
		var value = noise.get_noise_3d(direction.x,direction.y,direction.z)
		planet_mesh = ArrayMesh.new()
		#print(value)
		if value <= 0:
			color = color1
		elif value > 0 and value < 0.20:
			color = color2
		elif value > 0.20 and value < 0.35:
			color = color3
		else:
			color = color4
		
		vertex = direction * (radius + value * amplitude)
		planet_mdt.set_vertex(i,vertex)
		planet_mdt.set_vertex_color(i, color)
	
	planet_mdt.commit_to_surface(planet_mesh)
	planet.mesh = planet_mesh
	
func cloud_gen():
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 5
	
	var temp = ArrayMesh.new()
	temp.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,sphere.get_mesh_arrays())
	
	cloud_mdt.create_from_surface(temp, 0)
	cloud_mesh = ArrayMesh.new()
	
	for i in range(cloud_mdt.get_vertex_count()):
		var vertex = cloud_mdt.get_vertex(i)
		var color = Color()
		
		var direction = vertex.normalized()
		var value = noise.get_noise_3d(direction.x,direction.y,direction.z)
		#print(value)
		if value <= -0.15:
			color = cloud_color
		else:
			color = Color(1.0, 0.0, 0.0, 0.0)
		vertex = direction * (radius + value * amplitude) 
		cloud_mdt.set_vertex(i,vertex)
		cloud_mdt.set_vertex_color(i, color)

	cloud_mdt.commit_to_surface(cloud_mesh)
	clouds.mesh = cloud_mesh
	clouds.scale = Vector3(clouds.scale.x * 1.08,clouds.scale.y * 1.08,clouds.scale.z * 1.08)

func _process(delta):
	clouds.rotate_y(0.001)
	if Input.is_action_pressed("rotate_up"):
		clouds.rotate_x(0.02)
		planet.rotate_x(0.02)
	if Input.is_action_pressed("rotate_left"):
		clouds.rotate_y(0.02)
		planet.rotate_y(0.02)
	if Input.is_action_pressed("rotate_down"):
		clouds.rotate_x(-0.02)
		planet.rotate_x(-0.02)
	if Input.is_action_pressed("rotate_right"):
		clouds.rotate_y(-0.02)
		planet.rotate_y(-0.02)
	if Input.is_action_pressed("zoom_in"):
		$Camera3D.fov -= 1
	if Input.is_action_pressed("zoom_out"):
		$Camera3D.fov += 1
	if Input.is_action_just_pressed("reset"):
		clouds.rotation = Vector3(0,0,0)
		planet.rotation = Vector3(0,0,0)
		$Camera3D.fov = 75
