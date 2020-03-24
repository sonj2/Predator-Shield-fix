Hooks:PostHook(WeaponFactoryTweakData, "init", "WeaponFactoryTweakDatainit_akimbo_shield", function(wFac, ...)
	local _parts_name = {"mod_shield"}
	for k, v in pairs(wFac or {}) do
		if k ~= "parts" then
			--log('K_val: '..tostring(k))
			--log(string.sub(k, 1, 14))
			--log('Check_k:'..tostring(string.sub(k, 1, 14) == 'wpn_fps_pis_x_'))
			if string.find(k, '_x_')  then
				local _npc_k = k .. "_npc"
				if wFac[_npc_k] and v.uses_parts and wFac[_npc_k].uses_parts then
					for _, v2 in pairs(_parts_name or {}) do
						table.insert(wFac[k].uses_parts, v2)					
						table.insert(wFac[_npc_k].uses_parts, v2)
					end
				end
			end
		end
	end
end)

