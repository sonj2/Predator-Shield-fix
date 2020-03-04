shield_on = false

function AkimboWeaponBase:create_second_gun(create_second_gun)
	log('AkimboWeaponBase:create_second_gun')
	if managers.player:player_unit():inventory():akimbo_shield_check() then
		log('detected_gun')
		self._blueprint = {
			"wpn_fps_shield_body_akimbo"
		}
		shield_on = true
	end
	log('AkimboWeaponBase:Shield_on: '..tostring(shield_on))
	self:_create_second_gun(create_second_gun)
	self._setup.user_unit:camera()._camera_unit:link(Idstring("a_weapon_left"), self._second_gun, self._second_gun:orientation_object():name())
end

function AkimboWeaponBase:_fire_second(params)
	if shield_on then
		return
	end
	if alive(self._second_gun) and self._setup and alive(self._setup.user_unit) then
		local fired = self._second_gun:base().super.fire(self._second_gun:base(), unpack(params))
		if fired then
			if self._fire_second_sound then
				self._fire_second_sound = false
				self._second_gun:base():_fire_sound()
			end
			managers.hud:set_ammo_amount(self:selection_index(), self:ammo_info())
			self._second_gun:base():tweak_data_anim_play("fire")
		end
		return fired
	end
end

function AkimboWeaponBase:set_gadget_on(...)
	AkimboWeaponBase.super.set_gadget_on(self, ...)
	if shield_on then
		return
	end
	if alive(self._second_gun) then
		self._second_gun:base():set_gadget_on(...)
	end
end