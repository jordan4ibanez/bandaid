--simple bandaid mod

minetest.register_craftitem("bandaid:bandaid", {
	description = "Bandaid",
	inventory_image = "bandaid.png",
 
	on_place = function(itemstack, placer, pointed_thing)
		bandaid_heal(placer,itemstack)
		return(itemstack)
	end,
	on_secondary_use = function(itemstack, user, pointed_thing)
		bandaid_heal(user,itemstack)
		return(itemstack)
	end,
})
function bandaid_heal(player,itemstack)
		local hp  = player:get_hp()
		local pos = player:getpos() 
		if hp < 20 then
			player:set_hp(hp + 10)
			minetest.sound_play("relief", {
				pos = pos,
				max_hear_distance = 100,
				gain = 10.0,
			})
			minetest.add_item(pos, drop)
			  minetest.add_particlespawner({
				 amount = 40,
				 time = 0.1,
				 minpos = {x=pos.x-0.5, y=pos.y, z=pos.z-0.5},
				 maxpos = {x=pos.x+0.5, y=pos.y+1, z=pos.z+0.5},
				 minvel = {x=0, y=1, z=0},
				 maxvel = {x=0, y=2, z=0},
				 minacc = {x=0, y=0, z=0},
				 maxacc = {x=0, y=0, z=0},
				 minexptime = 1,
				 maxexptime = 1,
				 minsize = 1,
				 maxsize = 2,
				 collisiondetection = false,
				 vertical = false,
				 texture = "heart.png",
			})
			itemstack:take_item(1)
			return(itemstack)
		end
end
minetest.register_craft({
	output = "bandaid:bandaid",
	recipe = {
		{"default:paper", "group:wool", "default:paper"}
	}
})
