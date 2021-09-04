@tool
extends ArrayMesh

@export var surfaceColors: PackedFloat32Array = [1.0] :
	get:
		return surfaceColors
	set(value):
		surfaceColors = value
		resetSurfaces()
		emit_changed()

func resetSurfaces():
	var surfaceCount = get_surface_count()
	var dataTools = []
	for i in range(surfaceCount):
		var dataTool: MeshDataTool = MeshDataTool.new()
		dataTool.create_from_surface(self, i)
		if(i < surfaceColors.size()):
			var color : Color = Color(surfaceColors[i],0,0,0)
			for j in range(dataTool.get_vertex_count()):
				dataTool.set_vertex_custom_float(j, 0, color)
				# the color can be read from "CUSTOM0".
				# values are not clamped so no worries there.
		dataTools.append(dataTool)
	clear_surfaces()

	for i in range(surfaceCount):
		var dataTool : MeshDataTool = dataTools[i]
		dataTool.commit_to_surface(self)

func _ready():
	# the ready function might not be needed as the altered mesh will be saved 
	# along with the exported variable
	resetSurfaces()
	emit_changed()
	
