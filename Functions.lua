function get_direction()
	local rotationYaw, pitch = player.angles()
	local moveForward, moveStrafing = player.strafe()

	if moveForward < 0 then
		rotationYaw = rotationYaw + 180
	end

	local forward = 1

	if moveForward < 0 then
		forward = -0.5
	elseif moveForward > 0 then
		forward = 0.5
	end

	if moveStrafing > 0 then
		rotationYaw = rotationYaw - (90 * forward)
	elseif moveStrafing < 0 then
		rotationYaw = rotationYaw + (90 * forward)
	end

    return math.rad(rotationYaw)
end

function is_moving()
	local f, s = player.strafe()
	return not (f == 0 and s == 0)
end

function strafe(speed)
	if is_moving() then
		local yaw = get_direction()
		local m_x, m_y, m_z = player.motion()

		local new_m_x = -math.sin(yaw) * speed
		local new_m_z = math.cos(yaw) * speed

		player.set_motion(new_m_x, m_y, new_m_z)
	end
end
function fireball_slot()
	for i = 1, 9 do
	    local name = player.inventory.item_information(35 + i)
	    if name ~= nil then
	        if name == 'item.fireball' then
	        	return i, 'fireball'
	        end
	    end
	end
	return nil
end
function set_hotbar_slot(slot)
    slot = fireball_slot()
	player.set_held_item_slot(slot -2)
end
function get_forward_yaw()
	local player_yaw, player_pitch = player.angles()

	local potential_yaw_1 = player_yaw + 180
	local potential_yaw_2 = player_yaw - 180

	local difference_1 = math.abs(player_yaw - potential_yaw_1)
	local difference_2 = math.abs(player_yaw - potential_yaw_2)

	if difference_1 < difference_2 then
		return potential_yaw_1
	else
		return potential_yaw_2
	end
end
