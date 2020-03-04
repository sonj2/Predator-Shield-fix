local _hts_PlayerInventory_init = PlayerInventory.init

function PlayerInventory:init(...)
	_hts_PlayerInventory_init(self, ...)
	self.player_shield = false
	self.akimbo_shield_enabler = false
end

local _hts_PlayerInventory_place_selection = PlayerInventory._place_selection

function PlayerInventory:_place_selection(selection_index, is_equip)
	_hts_PlayerInventory_place_selection(self, selection_index, is_equip)
	if not self:is_this_able_to_shield() then
		return
	end
	if is_equip then
		self:give_shield()
	else
		self:hide_shield()
	end
end

function PlayerInventory:get_player_shield()
	return self.player_shield
end

function PlayerInventory:check_player_shield()
	return self.player_shield
end

function PlayerInventory:give_shield()
	if not self:is_this_able_to_shield() then
		return
	end
	
	self:hide_shield()
	local selection = self._available_selections[self._equipped_selection]
	if not selection then
		return
	end
	local weapon_unit = selection.unit
	local factory_id = weapon_unit:base()._factory_id
	local weapon_id = managers.weapon_factory:get_weapon_id_by_factory_id(factory_id)
	if (weapon_id ~= "predatorshield") and (weapon_id ~= "predatorshield_secondary") then
		--local equipped_primary = managers.blackmarket:equipped_primary()
		--local equipped_secondary = managers.blackmarket:equipped_secondary()
		if tweak_data and tweak_data.weapon and tweak_data.weapon[weapon_id] and tweak_data.weapon[weapon_id].category and tweak_data.weapon[weapon_id].category  == "akimbo" and self.akimbo_shield_check() then
			-- check here
		else
			return
		end
	end
	if self.akimbo_shield_check() then
		--log('akimbo_shield_enabler:'..tostring(self.akimbo_shield_enabler))
	end
	self.akimbo_shield_enabler = true
	local weap_align_data = selection.use_data["equip"]
	local align_place = self._align_places[weap_align_data.align_place]
	self.player_shield = true
end

function PlayerInventory:hide_shield()
	if not self:is_this_able_to_shield() then
		return
	end
	if self.player_shield then
		self.player_shield = false
	end
end

function PlayerInventory:is_this_able_to_shield()
	local peer = managers.network:session():peer_by_unit(self._unit)
	if peer and peer == managers.network:session():local_peer() then
		return true
	end
	return false
end

function PlayerInventory:akimbo_shield_enabled()
	return self.akimbo_shield_enabler
end

function PlayerInventory:akimbo_shield_check()
	local equipped_primary = managers.blackmarket:equipped_primary()
	if tweak_data.weapon[equipped_primary.weapon_id].category == "akimbo" then
		for index, value in ipairs(equipped_primary.blueprint) do
	        if value == "mod_shield" then
	            return true
	        end
	    end
	end	
	return false
end

