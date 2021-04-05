
function teleporter.getList(name, orderName, order)
	local list = "";
	local keys = {};
	local arr = teleporter.getReceiversArr(name, orderName, order)
	--print(dump(arr));
	for i = 1, #arr do
		local receiver = arr[i];
		local fav = receiver.fav or 0;
		local pub = receiver.pub or 0;
		--print(dump(receiver));
		keys[#keys+1] = fav..","..pub..","..minetest.formspec_escape(receiver.dest)..","..minetest.formspec_escape(receiver.name)..","..minetest.formspec_escape(receiver.desc);
	end
	--print(dump(keys));
	list = table.concat(keys,",");

	return list;
end

function teleporter.getReceiversArr(name, sortName, order)
	local list = teleporter.storage:getAll(name,{});
	sortName = sortName or "name";
	order = order or "ASC";
	local arr = {};
	for k, v in pairs(list) do
		arr[#arr+1] = v
	end
	--print(dump(arr));

	if(order == "ASC") then
		table.sort(arr, function(a,b)
			if(a[sortName] == b[sortName]) then
				return a["dest"]<b["dest"];
			else
				return a[sortName] < b[sortName];
			end
		end)
	else
		table.sort(arr, function(a,b)
			if(a[sortName] == b[sortName]) then
				return a["dest"]>b["dest"];
			else
				return a[sortName] > b[sortName];
			end
		end)
	end
	--print(dump(arr));
	return arr
end

function teleporter.getreceiverForm(pos)
	local meta = minetest.get_meta(pos);
	local public = meta:get_string("public");
	local fav = meta:get_string("favorite");
	local form = "size[8,5;]"..
	"label[0.1,0.0;Receiver Settings]"..
	"box[0.1,0.6;3,0.05;#FFFFFF]"..
	"checkbox[0.1,0.6;public;add this receiver to the public list (server-admins only);"..public.."]"..
	"checkbox[0.1,1;favorite;mark this receiver as favorite;"..fav.."]"..
	"field[0.3,2.5;4,1;name;Name of this Destination:;${name}]"..
	"field[0.3,3.5;8,1;desc;a short Description:;${desc}]"..
	"button_exit[4.1,4.4;4,1;save;OKAY]"..
	"button_exit[0.1,4.4;4,1;exit;Abort]"..
	teleporter.formbg;
	return form
end

function teleporter.receiver_placed(itemstack, placer, pointed_thing)
	local pos = pointed_thing.above;
	--print("receiver placed at ".. minetest.pos_to_string(pos));
	minetest.rotate_node(itemstack, placer, pointed_thing)
	local meta = minetest.get_meta(pos);
	-- Get placer's name.
	local name = placer:get_player_name();

	
	meta:set_string("formspec",teleporter.getreceiverForm(pos));
	meta:set_string("infotext", "NOT READY! \nRight-click to initialize!");
	meta:set_string("owner", name);
	return itemstack;
end

function teleporter.receiver_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos);
	if teleporter.can_access(pos,sender) then
		--print("Receiver submit: "..dump(fields));
		if fields.save and fields.name then
			
			meta:set_string("name",fields.name);
			meta:set_string("desc",fields.desc);
			meta:set_string("infotext","Receiver: "..fields.name.."\n"..fields.desc)
			teleporter.change_dest(meta:get_string("owner"),pos,fields.name,fields.desc);
			local node = minetest.get_node(pos);
			node.name = "teleporter:receiver_active";
			minetest.swap_node(pos,node);--zu guter letzt den Receiver anschalten
			if meta:get_string("public") == "true" then
				teleporter.change_dest("public",pos,fields.name,fields.desc);
			else
				teleporter.storage:del("public",minetest.pos_to_string(pos));
			end
		elseif fields.public then
			local privs = minetest.get_player_privs(sender:get_player_name())
			if privs["server"] then
				meta:set_string("public",fields.public);
				meta:set_string("formspec",teleporter.getreceiverForm(pos));

			else
				minetest.chat_send_player(sender:get_player_name(),"Teleporter -!-: you cannot add/remove this receiver to/from the public list. only the server admins are alowed to do it!")
			end
		elseif fields.favorite then
			meta:set_string("favorite",fields.favorite);
			meta:set_string("formspec",teleporter.getreceiverForm(pos));
		 
		end
	
	
	else
	minetest.chat_send_player(sender:get_player_name(),"Teleporter -!-: you cannot change the settings, only "..meta:get_string("owner").." or the server admins are alowed to do it!")
	end
end

function teleporter.receiver_removed(pos)
	local meta= minetest.get_meta(pos);	
	local owner = meta:get_string("owner");
	local public = meta:get_string("public");
	if owner ~= "" then
		--print("try to del teleporter of "..dump(owner).." at "..dump(pos))
		teleporter.storage:del(owner,minetest.pos_to_string(pos));
	end
	if public == "true" then
		--print("try to del public teleporter of "..dump(owner).."at "..dump(pos))
		teleporter.storage:del("public",minetest.pos_to_string(pos));
	end
end

function teleporter.change_dest(player,pos,name,desc)
	local meta = minetest.get_meta(pos);
	local public = meta:get_string("public")
	local fav = meta:get_string("favorite");
	if fav == "true" then
		fav = 1;
	else
		fav = 0;
	end
	if public == "true" then
		public = 1;
	else
		public = 0;
	end
	local data = {};
	data.fav = fav;
	data.pub = public;
	data.name = name;
	data.desc = desc;
	data.dest = minetest.pos_to_string(pos);
	teleporter.storage:set(player,minetest.pos_to_string(pos),data);--yay thats all :-)
	end
teleporter.types = {"public","private"};

function teleporter.getform(pos)
	local meta = minetest.get_meta(pos);
	local item = meta:get_int("item");
	local mode = meta:get_int("mode") or 0;
	local name = meta:get_string("owner");
	local public = meta:get_string("public")
	local order_by = meta:get_string("order_by") or "name";
	local order = meta:get_string("order") or "ASC";
	local form = "";
	if mode == 0 or mode == nil then --mode 0 means choose a receiver from the list
		local list = "";
		if public == "true" then
			list=teleporter.getList("public", order_by, order);
		else
			list = teleporter.getList(name, order_by, order);
		end
		if list == "" then
		list = "1,1,____pos____,_____Name_____,_____Description_____"
		else
		list = "1,1,____pos____,_____Name_____,_____Description_____,"..list
		end
		form = "size[10,7;]"..
		"label[0.1,0.0;Chose a Receiver from the list:]"..
		"box[0.1,0.6;6,0.05;#FFFFFF]"..
		"checkbox[0.1,0.6;public;show the Public Receiver list;"..public.."]"..
		"label[0.1,1.3;Known Receivers: ]"..
		"tablecolumns[image,tooltip=favorite,1=teleporter_bookmark.png;image,tooltip=public receiver,1=teleporter_world.png;text,tooltip=Coordinates,align=right;text,tooltip=Name;text,tooltip=Description]"..
		"table[0.1,1.7;9.7,4.5;dest;"..list..";"..item.."]"..
		"button[0.1,6.2;5.7,1;reload;reload list]"..
		"button[6.0,6.2;4.0,1;save_dest;OKAY]"..
		teleporter.formbg;
	else --mode 1 means the teleporter has a destination, an can be used
		form = "size[9,6;]"..
		"label[0.1,0.0;Teleporter Settings]"..
		"box[0.1,0.6;3,0.05;#FFFFFF]"..
		"label[0.1,1;Owner: "..meta:get_string("owner").."]"..
		"label[0.1,1.3;Uses Public Receiver: "..public.."]"..
		"label[0.1,2;Destination: "..meta:get_string("coords").."]"..
		"label[0.1,2.3;Name: "..meta:get_string("name").."]"..
		"label[0.1,2.6;Description: "..meta:get_string("desc").."]"..
		"button[0.1,5;5.7,1;unlink;Unlink destination and choose a new one]"..
		"button_exit[6.0,5;3.0,1;save;OKAY]"..
		teleporter.formbg;
	end
	return form	
end

function teleporter.placed(itemstack, placer, pointed_thing)
	local pos = pointed_thing.above;
	minetest.rotate_node(itemstack, placer, pointed_thing)
	local meta = minetest.get_meta(pos)
	local name = placer:get_player_name();
	meta:set_int("item",1);--the default
	meta:set_int("type",1);
	meta:set_string("owner", name);
	meta:set_string("infotext","Teleporter offline");
	meta:set_string("formspec",teleporter.getform(pos,name));
	return itemstack;
end
		






--alias teleporter:teleporter_pad to teleporter:teleporter

function teleporter.received_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos);
	local name = meta:get_string("owner");

	if teleporter.can_access(pos,sender) then
		--print("Player "..sender:get_player_name().." submitted fields "..dump(fields));
		if fields.reload then
			meta:set_string("formspec",teleporter.getform(pos));
			meta:set_int("item",1);
		elseif fields.unlink then
			meta:set_int("mode",0);
			meta:set_int("item",0);
			meta:set_string("formspec",teleporter.getform(pos));
			meta:set_string("infotext","Teleporter offline");--den infotext setzen
			local node = minetest.get_node(pos);
			node.name = "teleporter:teleporter";
			minetest.swap_node(pos,node);--zu guter letzt den Teleporter ausshalten.
		elseif fields.dest then
			local event = minetest.explode_table_event(fields.dest);
			
			if meta:get_string("public") == "true" then
				name = "public"
			end
			--print("wurde gesplitted",dump(event));
			meta:set_int("item",event.row);
			if(event.row == 1) then
				if(event.column == 1) then
					if(meta:get_string("order_by") == "fav") then
						teleporter.swap_order(meta)
					else
						meta:set_string("order_by", "fav")
					end
				elseif(event.column == 2) then
					if(meta:get_string("order_by") == "pub") then
						teleporter.swap_order(meta)
					else
						meta:set_string("order_by", "pub")
					end
				elseif(event.column == 3) then
					if(meta:get_string("order_by") == "dest") then
						teleporter.swap_order(meta)
					else
						meta:set_string("order_by", "dest")
					end
				elseif(event.column == 4) then
					if(meta:get_string("order_by") == "name") then
						teleporter.swap_order(meta)
					else
						meta:set_string("order_by", "name")
					end
				elseif (event.column == 5) then
					if(meta:get_string("order_by") == "desc") then
						teleporter.swap_order(meta)
					else
						meta:set_string("order_by", "desc")
					end
				end
				meta:set_string("formspec",teleporter.getform(pos));
			elseif event.row > 1 then -- The first row is invalid
				local order_by = meta:get_string("order_by") or "name";
				local order = meta:get_string("order") or "ASC";
				meta:set_string("coords",teleporter.getReceiversArr(name, order_by, order)[event.row-1].dest);--vom event index nochmal eins abziehen, weil ja der erste eintrag die titelleiste ist.
				--print("Receivers list:"..dump(teleporter.getReceiversArr(name)));
				--meta:set_string("formspec",teleporter.getform(pos));--no need for recreate formspec
			end
			
		elseif fields.save_dest	then --ok jetzt muss alles ueber den gewahlten Receiver gespeichert werden
			local coords = meta:get_string("coords");
			--print("save_dest");
			if coords == "" then --wenn keine coords festgelegt sind
				--meta:set_string("formspec",teleporter.getform(pos));
				meta:set_string("infotext","Teleporter offline");--den infotext setzen
				minetest.swap_node(pos,{name="teleporter:teleporter"});--zu guter letzt den Teleporter ausshalten.
			else
				if meta:get_string("public") == "true" then
				name = "public"; --work temprarly with "public" as name
				end
				local receiver = teleporter.storage:get(name,coords,{name="none",desc="No Receiver selected."});
				--print("Receiver: "..dump(receiver),"coords:"..dump(coords),"player:"..dump(name));
				meta:set_int("mode",1);--modus auf 1 setzen
				meta:set_string("name",receiver.name);
				meta:set_string("desc",receiver.name);
				meta:set_string("formspec",teleporter.getform(pos));--formular neu generieren
				meta:set_string("infotext","Teleport to "..receiver.name.."\n"..receiver.desc);--den infotext setzen
				local node = minetest.get_node(pos);
				node.name = "teleporter:teleporter_active";
				minetest.swap_node(pos,node);--zu guter letzt den Teleporter aktivschalten.
			end
		elseif fields.public then
			meta:set_int("item",0);
			meta:set_string("public",fields.public);
			meta:set_string("formspec",teleporter.getform(pos));
		end
	else
	minetest.chat_send_player(sender:get_player_name(),"Teleporter -!-: you cannot change the settings, only "..name.." or the server admins are alowed to do it!")
	end
end


teleporter.can_access = function(pos,player)
	local meta = minetest.env:get_meta(pos)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if name == meta:get_string("owner") or privs["server"] then
		return true
	end
	return false
end

teleporter.teleport = function(pos, radius)
	local objs = minetest.get_objects_inside_radius(pos, radius)
	if #objs >=1 then
		local meta = minetest.get_meta(pos);
		local owner = meta:get_string("owner");
		if meta:get_string("public") == "true" then --if the receiver is public change the owner to public
			owner = "public";
		end
		
		local dest = meta:get_string("coords");
		local topos = minetest.string_to_pos(dest);
		if teleporter.storage:get(owner,dest,false) then --if the receiver is aviable
			minetest.sound_play("teleporter_teleport", {pos = pos, gain = 1.0, max_hear_distance = radius+1,})
			for i=1, #objs do
				local obj = objs[i]
				--
				if obj:is_player() then
					obj:setpos({x=topos.x,y=topos.y-0.4,z=topos.z})
				else
					obj:setpos(topos)
				end
			end
			minetest.sound_play("teleporter_teleport", {pos = topos, gain = 1.0, max_hear_distance = 2,})
		else
			local err = "Error 404: no receiver pad at "..dest.." found. maybe its dug?\n"..
			"If you are shure there is a receiver, ask a server admin, you may found a bug!"
			meta:set_string("infotext", err);
			minetest.swap_node(pos,{name="teleporter:teleporter"});

			meta:set_string("formspec",teleporter.getform(pos,owner));
			minetest.sound_play("no_service", {pos = pos, gain = 0.5, max_hear_distance = 2,})
		end
	end
end

teleporter.swap_order = function(meta)
	if(meta:get_string("order")=="ASC") then
		meta:set_string("order", "DESC")
	else
		meta:set_string("order", "ASC")
	end
end
