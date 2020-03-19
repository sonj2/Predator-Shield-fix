local _hts_PlayerStandard_init = PlayerStandard.init

function PlayerStandard:init(...)
	_hts_PlayerStandard_init(self, ...)
	self._melee_hts_t = 0
end

local _hts_PlayerStandard_check_action_melee = PlayerStandard._check_action_melee

function PlayerStandard:_check_action_melee(t, input)
	if not self._unit:inventory():is_this_able_to_shield() then
		return
	end
	local _btn_melee_release = input.btn_melee_release
	local _btn_melee_press = input.btn_melee_press
	if managers.blackmarket:equipped_melee_weapon() == "weapon" then-- Get the current melee and check if is the weaponbutt
		if _btn_melee_press then
			self._melee_hts_t = 0
		end
		if _btn_melee_release and self._melee_hts_t == 0 then
			self._melee_hts_t = t + 1
		end
	else 
		if _btn_melee_press then
			self._unit:inventory():hide_shield() -- Hide shield if the player use a melee weapon that is not the weapon butt
			self._melee_hts_t = 0
		end
		if _btn_melee_release and self._melee_hts_t == 0 then
			self._melee_hts_t = t + 1
		end
	end
	_hts_PlayerStandard_check_action_melee(self, t, input)
end

local _hts_PlayerStandard_update = PlayerStandard.update

function PlayerStandard:update(t, ...)
	_hts_PlayerStandard_update(self, t, ...)
	if not self._unit:inventory():is_this_able_to_shield() then
		return
	end
	local state = managers.player:player_unit():movement():current_state()
    local tweak = tweak_data.player
    local weapon = alive(state._equipped_unit) and state._equipped_unit:base() 
    local weapon_id = weapon and weapon:get_name_id() or "default"
    local stances = tweak.stances[weapon_id]   
    --log('weapon_id'..tostring(weapon_id)) 
	if self._unit:inventory():check_player_shield() and tweak_data.weapon[weapon_id].category == "akimbo" then
		if string.find(tweak_data.weapon[weapon_id].categories, "pistol") then
			stances['standard'].shoulders.translation = mvector3.copy(Vector3(25, -20.403, -4.27))
			--stances['standard'].shoulders.rotation = mrotation.copy()
			stances['crouched'].shoulders.translation = mvector3.copy(Vector3(25, -20.403, -4.27))
			--stances['crouched'].shoulders.rotation = mrotation.copy()
			stances['steelsight'].shoulders.translation = mvector3.copy(Vector3(21, 0, -4.27))
			stances['steelsight'].shoulders.rotation = mrotation.copy(Rotation(0.349336, -0.256, -19.279))
		else if weapon_id == "x_mp5" then --akimbo mp5 has a different stance compared to other smgs
			stances['standard'].shoulders.translation = mvector3.copy(Vector3(25, -1.403, -3.67))
			--stances['standard'].shoulders.rotation = mrotation.copy()
			stances['crouched'].shoulders.translation = mvector3.copy(Vector3(25, -1.403, -3.67))
			--stances['crouched'].shoulders.rotation = mrotation.copy()
			stances['steelsight'].shoulders.translation = mvector3.copy(Vector3(21, 19.403, -3.67))
			stances['steelsight'].shoulders.rotation = mrotation.copy(Rotation(0.349336, -0.256, -19.279))
		else
			--log('is_akimbo')
			stances['standard'].shoulders.translation = mvector3.copy(Vector3(25, -20.403, -4.27))
			--stances['standard'].shoulders.rotation = mrotation.copy()
			stances['crouched'].shoulders.translation = mvector3.copy(Vector3(25, -20.403, -4.27))
			--stances['crouched'].shoulders.rotation = mrotation.copy()
			stances['steelsight'].shoulders.translation = mvector3.copy(Vector3(21, 0, -4.27))
			stances['steelsight'].shoulders.rotation = mrotation.copy(Rotation(0.349336, -0.256, -19.279))
		end
	end

	if not self:_is_reloading() and not self:_is_meleeing()  then
		--log('not_reloading_update')
		self._unit:inventory():give_shield()
		return
	end
	if self._melee_hts_t > 0 and t > self._melee_hts_t then
		self._melee_hts_t = 0
		self._unit:inventory():give_shield()
	end
	--[[
	if managers.player:has_category_upgrade("player", "run_and_shoot") == false and managers.player.RUN_AND_SHOOT == true then
		managers.player.RUN_AND_SHOOT = false -- True because if you don't have the akibo shield you dont have this boost
	end
	local equipped_primariy = managers.blackmarket:equipped_primary()
	if managers.player:has_category_upgrade("player", "run_and_shoot") == false and self._unit:inventory():is_this_able_to_shield() and tweak_data.weapon[equipped_primariy.weapon_id].category == "akimbo" then
		managers.player.RUN_AND_SHOOT = true -- True because the running animation sucks 
	end
	]]
	
end

local old_check_action_reload = PlayerStandard._check_action_reload

function PlayerStandard:_check_action_reload(t, input)
	old_check_action_reload(self, t, input )
	if not self:_is_reloading() then
		--log('not_reloading')
		return
	end
	local action_wanted = input.btn_reload_press
	if action_wanted then
		log('reloading')
		self._unit:inventory():hide_shield()
	end
end

local old_update_reload_timers = PlayerStandard._update_reload_timers
