local _hts_PlayerDamage_damage_bullet = PlayerDamage.damage_bullet
Hooks:PreHook(PlayerDamage, "damage_bullet", "PlayerDamage:damage_bullet", function(self, attack_data, ...)
	if not self:_chk_can_take_dmg() then
		return
	end
	if self._unit:inventory():check_player_shield() and attack_data and attack_data.col_ray.position then 
		local ply_camera = managers.player:player_unit():camera()
		local target_vec = attack_data.col_ray.position - ply_camera:position()
		local angle = target_vec:to_polar_with_reference(ply_camera:forward(), math.UP).spin
		if self._unit:inventory():akimbo_shield_enabled() then
			if (120 <= angle and angle <= 180) or (-180 <= angle and angle <= -120) and not self._unit:_is_interacting() then --120° Protection
				if ((not self._unit:_is_reloading() and (managers.player.RUN_AND_SHOOT or not self._unit:movement():running())) and not self._unit:movement():in_air()) then
					if (self._unit:movement():stamina() > 0) then
						if (self._unit:movement():crouching()) then
							self._unit:movement():subtract_stamina(attack_data.damage * 0.2)
							self._unit:movement():_restart_stamina_regen_timer()
						else
							self._unit:movement():subtract_stamina(attack_data.damage * 0.3)
							self._unit:movement():_restart_stamina_regen_timer()
						end
						attack_data.damage = attack_data.damage * 0.2
					else
						attack_data.damage = attack_data.damage * 0.3
					end
				else
					attack_data.damage = attack_data.damage * 0.4
				end
			end
			if (90 <= angle and angle <= 180) or (-180 <= angle and angle <= -90) and self._unit:_is_interacting() then
				attack_data.damage = attack_data.damage * 0.8
			end
		else
			--space
		end
	end
	--_hts_PlayerDamage_damage_bullet(self, attack_data, ...)
end)

--[[function PlayerDamage:damage_bullet(attack_data, ...)
	if not self:_chk_can_take_dmg() then
		return
	end
	if self._unit:inventory():check_player_shield() and attack_data and attack_data.col_ray.position then 
		local ply_camera = managers.player:player_unit():camera()
		local target_vec = attack_data.col_ray.position - ply_camera:position()
		local angle = target_vec:to_polar_with_reference(ply_camera:forward(), math.UP).spin
		if self._unit:inventory():akimbo_shield_enabled() then
			if (120 <= angle and angle <= 180) or (-180 <= angle and angle <= -120) and not self._unit:_is_interacting() then --120° Protection
				if ((not self._unit:_is_reloading() and (managers.player.RUN_AND_SHOOT or not self._unit:movement():running())) and not self._unit:movement():in_air()) then
					if (self._unit:movement():stamina() > 0) then
						if (self._unit:movement():crouching()) then
							self._unit:movement():subtract_stamina(attack_data.damage * 0.2)
							self._unit:movement():_restart_stamina_regen_timer()
						else
							self._unit:movement():subtract_stamina(attack_data.damage * 0.3)
							self._unit:movement():_restart_stamina_regen_timer()
						end
						attack_data.damage = attack_data.damage * 0.2
					else
						attack_data.damage = attack_data.damage * 0.3
					end
				else
					attack_data.damage = attack_data.damage * 0.4
				end
			end
			if (90 <= angle and angle <= 180) or (-180 <= angle and angle <= -90) and self._unit:_is_interacting() then
				attack_data.damage = attack_data.damage * 0.8
			end
		else
			--space
		end
	end
	_hts_PlayerDamage_damage_bullet(self, attack_data, ...)
end]]
