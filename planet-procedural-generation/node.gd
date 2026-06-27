extends Node3D
@export var mesh_instance_3d: MeshInstance3D

var φ = (1.0 + sqrt(5.0)) / 2.0

var vertices = PackedVector3Array([
	Vector3(0, 0, 0),
	Vector3(1, 0, 0),
	Vector3(0, 1, 0)
])

var icosphere_vertices = [
	Vector3(-1,  φ, 0),
	Vector3( 1,  φ, 0),
	Vector3(-1, -φ, 0),
	Vector3( 1, -φ, 0),
	Vector3(0, -1,  φ),
	Vector3(0,  1,  φ),
	Vector3(0, -1, -φ),
	Vector3(0,  1, -φ),
	Vector3( φ, 0, -1),
	Vector3( φ, 0,  1),
	Vector3(-φ, 0, -1),
	Vector3(-φ, 0,  1)
]

enum Face{a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,u,s}

var face_indices = {
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
	Face.a
}

func _ready():
	var vertices = PackedVector3Array()
	vertices.push_back(Vector3(0, 1, 0))
	vertices.push_back(Vector3(1, 0, 0))
	vertices.push_back(Vector3(0, 0, 1))

	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	#arrays

	# Create the Mesh.
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	mesh_instance_3d.mesh = arr_mesh
