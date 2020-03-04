local _hts_PlayerDamage_damage_bullet = PlayerDamage.damage_bullet

function PlayerDamage:damage_bullet(attack_data, ...)
	if not self:_chk_can_take_dmg() then
		return
	end
	if self._unit:inventory():check_player_shield() and attack_data and attack_data.col_ray.position then
		local ply_camera = managers.player:player_unit():camera()
		local target_vec = attack_data.col_ray.position - ply_camera:position()
		local angle = target_vec:to_polar_with_reference(ply_camera:forward(), math.UP).spin
		if self._unit:inventory():akimbo_shield_enabled() then
			if (120 <= angle and angle <= 180) or (-180 <= angle and angle <= -120) then --120° Protection
				--log('angle:'..tostring(angle))
				--log(tostring("Dmg blocked"))
				--log(tostring(attack_data.damage))
				--managers.player:update_synced_cocaine_stacks_to_peers(1000, 2, 2)
				attack_data.damage = 0.0001
			--else
			--	log('Hit_angle:'..tostring(angle))
			end
		else
			if (90 <= angle and angle <= 180) or (-180 <= angle and angle <= -90) then
				--log('angle:'..tostring(angle))
				--log(tostring("Dmg blocked"))
				--log(tostring(attack_data.damage))
				--managers.player:update_synced_cocaine_stacks_to_peers(1000, 2, 2)
				attack_data.damage = 0.0001
			end
		end
	end
	_hts_PlayerDamage_damage_bullet(self, attack_data, ...)
end