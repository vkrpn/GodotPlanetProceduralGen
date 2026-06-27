extends Node

var mesh = ArrayMesh.new()
var mesh_object = MeshInstance3D.new()

var vertices = PackedVector3Array([
	Vector3(0, 0, 0),
	Vector3(1, 0, 0),
	Vector3(0, 1, 0)
])

func _ready():
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh_object.mesh = mesh
