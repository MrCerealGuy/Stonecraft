
-- beds are of special intrest for mobs in some situations (they can sleep there)

-- node names of nodes that are beds
handle_schematics.bed_node_names = {};
handle_schematics.bed_node_names['cottages:bed_head'] = 1;
handle_schematics.bed_node_names['beds:bed_top'] = 1;
handle_schematics.bed_node_names['beds:fancy_bed_top'] = 1;
handle_schematics.bed_node_names['cottages:sleeping_mat_head'] = 1;

-- content ids of nodes that are beds
handle_schematics.bed_content_ids = {};
for k,v in pairs( handle_schematics.bed_node_names ) do
	if( handle_schematics.node_defined( k ) and minetest.get_content_id( k )>0) then
		handle_schematics.bed_content_ids[ minetest.get_content_id( k ) ] = 1;
	end
end
