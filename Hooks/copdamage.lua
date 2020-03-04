local _KnockDownBoost_CopDamagedamage_melee = CopDamage.damage_melee

function CopDamage:damage_melee(attack_data)
	if self._unit:base()._tweak_table ~= "tank" then
		if managers.player:player_unit():inventory():akimbo_shield_enabled() and managers.blackmarket:equipped_melee_weapon() == "weapon" then
			attack_data.variant = 'counter_spooc'
			--shield knockdown POWER! It's balanced - cit
		end
	end
	return _KnockDownBoost_CopDamagedamage_melee(self, attack_data)
end
